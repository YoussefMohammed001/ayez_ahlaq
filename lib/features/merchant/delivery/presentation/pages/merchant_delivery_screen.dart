import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/delivery_settings.dart';
import '../manager/merchant_delivery_cubit.dart';
import '../manager/merchant_delivery_state.dart';
import '../widgets/delivery_fee_fields.dart';
import '../widgets/delivery_toggle_card.dart';

class MerchantDeliveryScreen extends StatefulWidget {
  const MerchantDeliveryScreen({super.key});

  @override
  State<MerchantDeliveryScreen> createState() => _MerchantDeliveryScreenState();
}

class _MerchantDeliveryScreenState extends State<MerchantDeliveryScreen> {
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

  void _hydrate(DeliverySettings settings) {
    if (_hydrated) return;
    _hydrated = true;
    _offered = settings.offered;
    _feeController.text = settings.fee > 0 ? '${settings.fee}' : '';
    _freeOverController.text =
        settings.hasFreeThreshold ? '${settings.freeOver}' : '';
  }

  Future<void> _submit() async {
    if (_offered && !_formKey.currentState!.validate()) return;

    final cubit = context.read<MerchantDeliveryCubit>();
    final saved = await cubit.saveDelivery(
      DeliverySettings(
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
    return Scaffold(
      appBar: AppTopBar(title: S().deliveryTitle),
      body: BlocBuilder<MerchantDeliveryCubit, MerchantDeliveryState>(
        builder: (context, state) {
          if (state.status == DeliveryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DeliveryStatus.failure && !_hydrated) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<MerchantDeliveryCubit>().loadDelivery,
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
                DeliveryToggleCard(
                  offered: _offered,
                  onChanged: (value) => setState(() => _offered = value),
                ),
                if (_offered)
                  DeliveryFeeFields(
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
      ),
    );
  }
}
