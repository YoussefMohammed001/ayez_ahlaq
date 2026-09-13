import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import '../widgets/cart_line_row.dart';
import '../widgets/cart_quote_card.dart';
import '../widgets/store_fulfillment_section.dart';
import '../widgets/store_line_item_row.dart';

class BarberStoreCartScreen extends StatefulWidget {
  const BarberStoreCartScreen({super.key});

  @override
  State<BarberStoreCartScreen> createState() => _BarberStoreCartScreenState();
}

class _BarberStoreCartScreenState extends State<BarberStoreCartScreen> {
  final _noteController = TextEditingController();
  late final _addressController = TextEditingController(
    text: context.read<BarberStoreCartCubit>().state.deliveryAddress,
  );

  @override
  void dispose() {
    _noteController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<BarberStoreCartCubit>();
    cubit.setNote(_noteController.text.trim());
    cubit.setDeliveryLocation(address: _addressController.text.trim());
    final result = await cubit.submitOrder();

    if (!context.mounted) return;

    if (result != null) {
      cubit.reset();
      context.go(
        Routes.successScreen,
        extra: SuccessScreenArgs(
          message: result.$2.isEmpty ? S().orderPlaced : result.$2,
          doneRoute: Routes.barberShell,
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
      body: BlocConsumer<BarberStoreCartCubit, BarberStoreCartState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null && current.errorMessage != previous.errorMessage,
        listener: (context, state) => showError(state.errorMessage!),
        builder: (context, state) {
          final cubit = context.read<BarberStoreCartCubit>();

          if (state.cart.isEmpty) {
            return AppEmptyState(icon: Icons.shopping_cart_outlined, title: S().cartEmpty);
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              for (final line in state.cart.lines)
                CartLineRow(
                  line: line,
                  onQuantityChanged: (quantity) => cubit.setQuantity(
                    line.productId,
                    line.minOrderQty,
                    quantity,
                  ),
                ),
              if (state.quote.lines.any((line) => line.gift)) ...[
                SectionTitle(title: S().quoteGift),
                for (final line in state.quote.lines.where((line) => line.gift))
                  StoreLineItemRow(item: line),
              ],
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
              SectionTitle(title: S().orderNoteTitle),
              AppTextField(
                controller: _noteController,
                hint: S().orderNoteHint,
                maxLines: 3,
              ),
              SizedBox(height: 12.h),
              CartQuoteCard(quote: state.quote, isUpdating: state.isUpdatingCart),
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
