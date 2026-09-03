import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/alerts.dart';
import '../../../../../../core/widgets/app_error_state.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_delivery_settings.dart';
import '../manager/barber_storefront_delivery_cubit.dart';
import '../manager/barber_storefront_delivery_state.dart';
import '../widgets/storefront_delivery_fee_fields.dart';
import '../widgets/storefront_delivery_toggle_card.dart';

class BarberStorefrontDeliveryScreen extends StatefulWidget {
  const BarberStorefrontDeliveryScreen({super.key});

  @override
  State<BarberStorefrontDeliveryScreen> createState() =>
      _BarberStorefrontDeliveryScreenState();
}

class _BarberStorefrontDeliveryScreenState
    extends State<BarberStorefrontDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feeController = TextEditingController();
  final _freeOverController = TextEditingController();
  bool _offered = false;
  bool _hydrated = false;

  @override
  void dispose() {
    _feeController.dispose();
    _freeOverController.dispose();
    super.dispose();
  }

  void _hydrate(StorefrontDeliverySettings settings) {
    if (_hydrated) return;
    _hydrated = true;
    _offered = settings.offered;
    _feeController.text = settings.fee > 0 ? '${settings.fee}' : '';
    _freeOverController.text =
        settings.hasFreeThreshold ? '${settings.freeOver}' : '';
  }

  Future<void> _submit() async {
    if (_offered && !_formKey.currentState!.validate()) return;

    final cubit = context.read<BarberStorefrontDeliveryCubit>();
    final saved = await cubit.saveDelivery(
      StorefrontDeliverySettings(
        offered: _offered,
        fee: _offered ? int.tryParse(_feeController.text.trim()) ?? 0 : 0,
        freeOver: _offered
            ? int.tryParse(_freeOverController.text.trim())
            : null,
      ),
    );

    if (!mounted) return;

    if (saved) {
      showSuccess(S().deliverySaved);
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontDeliveryCubit, BarberStorefrontDeliveryState>(
      builder: (context, state) {
        if (state.status == StorefrontDeliveryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == StorefrontDeliveryStatus.failure && !_hydrated) {
          return AppErrorState(
            message: state.errorMessage,
            onRetry: context.read<BarberStorefrontDeliveryCubit>().loadDelivery,
          );
        }

        _hydrate(state.settings);

        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              Text(
                S().deliveryNote,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.8,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              StorefrontDeliveryToggleCard(
                offered: _offered,
                onChanged: (value) => setState(() => _offered = value),
              ),
              if (_offered)
                StorefrontDeliveryFeeFields(
                  feeController: _feeController,
                  freeOverController: _freeOverController,
                ),
              SizedBox(height: 26.h),
              PrimaryCtaButton(
                label: S().save,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        );
      },
    );
  }
}
