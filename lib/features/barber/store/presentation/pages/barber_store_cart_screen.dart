import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/fulfillment_type.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import '../widgets/cart_line_row.dart';
import '../widgets/cart_quote_card.dart';
import '../widgets/fulfillment_type_label.dart';

class BarberStoreCartScreen extends StatefulWidget {
  const BarberStoreCartScreen({super.key});

  @override
  State<BarberStoreCartScreen> createState() => _BarberStoreCartScreenState();
}

class _BarberStoreCartScreenState extends State<BarberStoreCartScreen> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<BarberStoreCartCubit>();
    final order = await cubit.submitOrder();

    if (!context.mounted) return;

    if (order != null) {
      showSuccess(S().orderPlaced);
      cubit.reset();
      context.go(Routes.barberStoreOrdersScreen);
    } else {
      showError(cubit.state.errorMessage ?? S().somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().cartTitle),
      body: BlocBuilder<BarberStoreCartCubit, BarberStoreCartState>(
        builder: (context, state) {
          final cubit = context.read<BarberStoreCartCubit>();

          if (state.lines.isEmpty) {
            return AppEmptyState(icon: Icons.shopping_cart_outlined, title: S().cartEmpty);
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              for (final line in state.lines)
                CartLineRow(
                  line: line,
                  onRemove: () {
                    cubit.setQuantity(line.product, 0);
                    cubit.refreshQuote();
                  },
                ),
              SectionTitle(title: S().fulfilmentTitle),
              OptionTile(
                label: FulfillmentType.delivery.label,
                icon: Icons.local_shipping_outlined,
                selected: state.fulfillmentType == FulfillmentType.delivery,
                onTap: () {
                  cubit.setFulfillmentType(FulfillmentType.delivery);
                  cubit.refreshQuote();
                },
              ),
              OptionTile(
                label: FulfillmentType.pickupAtBranch.label,
                icon: Icons.storefront_outlined,
                selected: state.fulfillmentType == FulfillmentType.pickupAtBranch,
                onTap: () {
                  cubit.setFulfillmentType(FulfillmentType.pickupAtBranch);
                  cubit.refreshQuote();
                },
              ),
              SectionTitle(title: S().orderNoteTitle),
              AppTextField(
                controller: _noteController,
                hint: S().orderNoteHint,
                maxLines: 3,
              ),
              SizedBox(height: 12.h),
              if (state.quote != null)
                CartQuoteCard(quote: state.quote!, isQuoting: state.isQuoting),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().placeOrder,
                isLoading: state.isSubmitting,
                onPressed: () {
                  cubit.setNote(_noteController.text.trim());
                  _submit(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
