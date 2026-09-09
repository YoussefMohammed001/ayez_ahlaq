import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/helpers/alerts.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../shared/widgets/switch_row_widget.dart';
import '../../../../../../core/widgets/image_picker_row.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/requests/storefront_category_form_request.dart';
import '../../domain/entities/storefront_category.dart';
import '../manager/barber_storefront_categories_cubit.dart';
import '../manager/barber_storefront_categories_state.dart';

class AddStorefrontCategorySheet extends StatefulWidget {
  final StorefrontCategory? editing;

  const AddStorefrontCategorySheet({super.key, this.editing});

  static Future<void> show(BuildContext context, {StorefrontCategory? editing}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BarberStorefrontCategoriesCubit>(),
        child: AddStorefrontCategorySheet(editing: editing),
      ),
    );
  }

  @override
  State<AddStorefrontCategorySheet> createState() =>
      _AddStorefrontCategorySheetState();
}

class _AddStorefrontCategorySheetState
    extends State<AddStorefrontCategorySheet> {
  late final _controller = TextEditingController(text: widget.editing?.name);
  List<XFile> _images = [];
  bool _removeImage = false;

  bool get _isEditing => widget.editing != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    final cubit = context.read<BarberStorefrontCategoriesCubit>();
    final request = StorefrontCategoryFormRequest(
      name: name,
      imagePath: _images.isEmpty ? null : _images.first.path,
      removeImage: _removeImage,
    );

    final saved = _isEditing
        ? await cubit.updateCategory(widget.editing!.id, request)
        : await cubit.createCategory(request);

    if (!mounted) return;

    if (saved) {
      Navigator.of(context).pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        0,
        20.w,
        MediaQuery.viewInsetsOf(context).bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: _isEditing ? S().editCategory : S().newCategory),
          AppTextField(controller: _controller, hint: S().newCategoryHint),
          SectionTitle(title: S().categoryImage),
          ImagePickerRow(
            images: _images,
            maxCount: 1,
            onChanged: (images) => setState(() {
              _images = images;
              if (images.isNotEmpty) _removeImage = false;
            }),
          ),
          if (_isEditing && widget.editing!.hasImage && _images.isEmpty) ...[
            SizedBox(height: 8.h),
            SwitchRow(
              label: S().removeCurrentImage,
              value: _removeImage,
              cs: context.colorScheme,
              onChanged: (value) => setState(() => _removeImage = value),
            ),
          ],
          SizedBox(height: 16.h),
          BlocBuilder<
            BarberStorefrontCategoriesCubit,
            BarberStorefrontCategoriesState
          >(
            builder: (context, state) => PrimaryCtaButton(
              label: _isEditing ? S().save : S().add,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
