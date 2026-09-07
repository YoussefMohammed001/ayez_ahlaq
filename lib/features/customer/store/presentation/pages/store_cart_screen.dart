import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../../../../../generated/l10n.dart';
import '../../../payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../../../payment_methods/presentation/manager/payment_methods_state.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/store_cart_line_row.dart';
import '../widgets/store_fulfillment_type_label.dart';
import '../widgets/store_quote_card.dart';

class StoreCartScreen extends StatefulWidget {
  const StoreCartScreen({super.key});

  @override
  State<StoreCartScreen> createState() => _StoreCartScreenState();
}

class _StoreCartScreenState extends State<StoreCartScreen> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<StoreCartCubit>().refreshQuote();
    context.read<PaymentMethodsCubit>().loadMethods();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<StoreCartCubit>();
    await cubit.placeOrder(note: _noteController.text.trim());

    if (!context.mounted) return;

    if (cubit.state.status == StoreCartStatus.orderPlaced) {
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
      body: BlocBuilder<StoreCartCubit, StoreCartState>(
        builder: (context, state) {
          final cubit = context.read<StoreCartCubit>();

          if (state.isEmpty) {
            return AppEmptyState(icon: Icons.shopping_cart_outlined, title: S().cartEmpty);
          }

          final products = {for (final p in state.storefront?.products ?? []) p.id: p};

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              for (final entry in state.items.entries)
                StoreCartLineRow(
                  productName: products[entry.key]?.name ?? '',
                  quantity: entry.value,
                  unitPrice: products[entry.key]?.price ?? 0,
                  lineTotal: (products[entry.key]?.price ?? 0) * entry.value,
                  minOrderQty: products[entry.key]?.minOrderQty ?? 1,
                  onQuantityChanged: (quantity) => cubit.setQuantity(entry.key, quantity),
                ),
              SectionTitle(title: S().fulfilmentTitle),
              OptionTile(
                label: StoreFulfillmentType.delivery.label,
                icon: Icons.local_shipping_outlined,
                selected: state.fulfillmentType == StoreFulfillmentType.delivery,
                enabled: state.storefront?.delivery.offered ?? true,
                disabledReason: S().deliveryNotOfferedReason,
                onTap: () {
                  cubit.setFulfillmentType(StoreFulfillmentType.delivery);
                  cubit.refreshQuote();
                },
              ),
              OptionTile(
                label: StoreFulfillmentType.pickupAtBranch.label,
                icon: Icons.storefront_outlined,
                selected: state.fulfillmentType == StoreFulfillmentType.pickupAtBranch,
                onTap: () {
                  cubit.setFulfillmentType(StoreFulfillmentType.pickupAtBranch);
                  cubit.refreshQuote();
                },
              ),
              BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                builder: (context, paymentState) {
                  if (paymentState.methods.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: S().paymentMethodsSectionTitle),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: paymentState.methods
                            .map(
                              (method) => ChoiceChip(
                                label: Text(method.label),
                                selected: state.paymentMethod == method.code,
                                onSelected: (_) => cubit.setPaymentMethod(method.code),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                },
              ),
              SectionTitle(title: S().orderNoteTitle),
              AppTextField(controller: _noteController, hint: S().orderNoteHint, maxLines: 3),
              SizedBox(height: 12.h),
              StoreQuoteCard(
                quote: state.quote,
                fallbackSubtotal: state.subtotal,
                isUpdating: state.status == StoreCartStatus.quoting,
              ),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().placeOrder,
                isLoading: state.status == StoreCartStatus.placingOrder,
                onPressed: () => _submit(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
