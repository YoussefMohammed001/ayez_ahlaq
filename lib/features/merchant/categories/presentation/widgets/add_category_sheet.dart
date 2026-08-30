import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/image_picker_row.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../data/requests/category_form_request.dart';
import '../../domain/entities/merchant_category.dart';
import '../manager/merchant_categories_cubit.dart';
import '../manager/merchant_categories_state.dart';
import '../../../../../generated/l10n.dart';

class AddCategorySheet extends StatefulWidget {
  final MerchantCategory? category;

  const AddCategorySheet({super.key, this.category});

  static Future<void> show(BuildContext context, {MerchantCategory? category}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MerchantCategoriesCubit>(),
        child: AddCategorySheet(category: category),
      ),
    );
  }

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  late final _controller = TextEditingController(text: widget.category?.name);
  List<XFile> _images = [];

  bool get _isEditing => widget.category != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    final cubit = context.read<MerchantCategoriesCubit>();
    final request = CategoryFormRequest(
      name: name,
      sortOrder: widget.category?.sortOrder ?? 0,
      imagePath: _images.isEmpty ? null : _images.first.path,
    );

    final saved = _isEditing
        ? await cubit.updateCategory(widget.category!.id, request)
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
            onChanged: (images) => setState(() => _images = images),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
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
