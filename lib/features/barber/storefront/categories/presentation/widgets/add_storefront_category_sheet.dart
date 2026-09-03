import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/helpers/alerts.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/image_picker_row.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/requests/storefront_category_form_request.dart';
import '../manager/barber_storefront_categories_cubit.dart';
import '../manager/barber_storefront_categories_state.dart';

class AddStorefrontCategorySheet extends StatefulWidget {
  const AddStorefrontCategorySheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BarberStorefrontCategoriesCubit>(),
        child: const AddStorefrontCategorySheet(),
      ),
    );
  }

  @override
  State<AddStorefrontCategorySheet> createState() =>
      _AddStorefrontCategorySheetState();
}

class _AddStorefrontCategorySheetState
    extends State<AddStorefrontCategorySheet> {
  final _controller = TextEditingController();
  List<XFile> _images = [];

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
    );

    final saved = await cubit.createCategory(request);

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
          SectionTitle(title: S().newCategory),
          AppTextField(controller: _controller, hint: S().newCategoryHint),
          SectionTitle(title: S().categoryImage),
          ImagePickerRow(
            images: _images,
            maxCount: 1,
            onChanged: (images) => setState(() => _images = images),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<
            BarberStorefrontCategoriesCubit,
            BarberStorefrontCategoriesState
          >(
            builder: (context, state) => PrimaryCtaButton(
              label: S().add,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
