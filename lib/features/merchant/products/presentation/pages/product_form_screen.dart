import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../domain/entities/merchant_product.dart';
import '../manager/merchant_products_cubit.dart';
import '../manager/merchant_products_state.dart';
import '../manager/product_form_controllers.dart';
import '../widgets/product_form_fields.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductFormScreen extends StatefulWidget {
  final MerchantProduct? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _controllers = ProductFormControllers(widget.product);
  List<XFile> _images = [];

  bool get _isEditing => widget.product != null;

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<MerchantProductsCubit>();
    final request = _controllers.buildRequest(
      imagePaths: _images.map((e) => e.path).toList(),
      keepImageIds: _isEditing ? widget.product!.imageIds : null,
    );

    final saved = _isEditing
        ? await cubit.updateProduct(widget.product!.id, request)
        : await cubit.createProduct(request);

    if (!mounted) return;

    if (saved) {
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: _isEditing ? S().editProduct : S().addWholesaleProduct,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            Text(
              S().productFormNote,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.8,
              ),
            ),
            ProductFormFields(
              controllers: _controllers,
              images: _images,
              onImagesChanged: (images) => setState(() => _images = images),
              onCategoryChanged: (value) =>
                  setState(() => _controllers.categoryId = value),
              productId: widget.product?.id,
              existingImageIds: widget.product?.imageIds ?? const [],
              onDeleteImage: _isEditing
                  ? (imageId) => context
                        .read<MerchantProductsCubit>()
                        .deleteImage(widget.product!.id, imageId)
                  : null,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
              builder: (context, state) => PrimaryCtaButton(
                label: _isEditing ? S().saveChanges : S().publishProduct,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
