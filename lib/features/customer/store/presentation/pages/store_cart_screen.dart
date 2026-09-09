import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../../../../../generated/l10n.dart';
import '../../../payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/store_cart_line_row.dart';
import '../widgets/store_cart_summary_card.dart';
import '../widgets/store_fulfillment_section.dart';
import '../widgets/store_payment_methods_section.dart';

class StoreCartScreen extends StatefulWidget {
  const StoreCartScreen({super.key});

  @override
  State<StoreCartScreen> createState() => _StoreCartScreenState();
}

class _StoreCartScreenState extends State<StoreCartScreen> {
  final _noteController = TextEditingController();
  late final _addressController = TextEditingController(
    text: context.read<StoreCartCubit>().state.deliveryAddress,
  );

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodsCubit>().loadMethods();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<StoreCartCubit>();
    cubit.setNote(_noteController.text.trim());
    cubit.setDeliveryLocation(address: _addressController.text.trim());
    final order = await cubit.submitOrder();

    if (!context.mounted) return;

    if (order != null) {
      cubit.reset();
      context.go(
        Routes.successScreen,
        extra: SuccessScreenArgs(
          message: S().orderPlaced,
          doneRoute: Routes.customerStoreOrdersScreen,
        ),
      );
    } else {
      showError(cubit.state.errorMessage ?? S().somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().cartTitle),
      body: BlocConsumer<StoreCartCubit, StoreCartState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null && current.errorMessage != previous.errorMessage,
        listener: (context, state) => showError(state.errorMessage!),
        builder: (context, state) {
          final cubit = context.read<StoreCartCubit>();

          if (state.isEmpty) {
            return AppEmptyState(icon: Icons.shopping_cart_outlined, title: S().cartEmpty);
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              for (final line in state.cart.lines)
                StoreCartLineRow(
                  line: line,
                  onQuantityChanged: (quantity) =>
                      cubit.setQuantity(line.productId, line.minOrderQty, quantity),
                ),
              StoreFulfillmentSection(
                cart: state.cart,
                fulfillmentType: state.fulfillmentType,
                addressController: _addressController,
                deliveryLat: state.deliveryLat,
                deliveryLng: state.deliveryLng,
                onTypeChanged: cubit.setFulfillmentType,
                onLocationPicked: (lat, lng) =>
                    cubit.setDeliveryLocation(lat: lat, lng: lng),
              ),
              StorePaymentMethodsSection(
                selectedCode: state.paymentMethod,
                onChanged: cubit.setPaymentMethod,
              ),
              SectionTitle(title: S().orderNoteTitle),
              AppTextField(controller: _noteController, hint: S().orderNoteHint, maxLines: 3),
              SizedBox(height: 12.h),
              StoreCartSummaryCard(
                cart: state.cart,
                isUpdating: state.isUpdatingCart,
              ),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().placeOrder,
                isLoading: state.isSubmitting,
                onPressed: () => _submit(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
