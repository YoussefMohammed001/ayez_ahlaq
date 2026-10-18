import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/home_service_settings.dart';
import '../manager/home_service_settings_cubit.dart';
import '../manager/home_service_settings_state.dart';
import '../widgets/home_service_price_fields.dart';
import '../widgets/home_service_toggle_card.dart';

class HomeServiceSettingsScreen extends StatefulWidget {
  const HomeServiceSettingsScreen({super.key});

  @override
  State<HomeServiceSettingsScreen> createState() =>
      _HomeServiceSettingsScreenState();
}

class _HomeServiceSettingsScreenState
    extends State<HomeServiceSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();
  bool _enabled = false;
  bool _hydrated = false;

  @override
  void dispose() {
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _hydrate(HomeServiceSettings settings) {
    if (_hydrated) return;
    _hydrated = true;
    _enabled = settings.enabled;
    _priceController.text = settings.price != null ? '${settings.price}' : '';
    _noteController.text = settings.note ?? '';
  }

  Future<void> _submit() async {
    if (_enabled && !_formKey.currentState!.validate()) return;

    final cubit = context.read<HomeServiceSettingsCubit>();
    final saved = await cubit.save(
      enabled: _enabled,
      price: _enabled ? int.tryParse(_priceController.text.trim()) : null,
      note: _enabled && _noteController.text.trim().isNotEmpty
          ? _noteController.text.trim()
          : null,
    );

    if (!mounted) return;

    if (saved) showSuccess(S().homeServiceSettingsSaved);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<HomeServiceSettingsCubit, HomeServiceSettingsState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().homeServiceSettingsTitle),
        body: BlocBuilder<HomeServiceSettingsCubit, HomeServiceSettingsState>(
          builder: (context, state) {
            if (state.status == HomeServiceSettingsStatus.loading &&
                !_hydrated) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeServiceSettingsStatus.failure &&
                !_hydrated) {
              return AppErrorState(
                message: state.errorMessage,
                onRetry: context.read<HomeServiceSettingsCubit>().loadSettings,
              );
            }

            _hydrate(state.settings);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                children: [
                  Text(
                    S().homeServiceNote,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      height: 1.8,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  HomeServiceToggleCard(
                    enabled: _enabled,
                    onChanged: (value) => setState(() => _enabled = value),
                  ),
                  if (_enabled) ...[
                    SizedBox(height: 16.h),
                    HomeServicePriceFields(
                      priceController: _priceController,
                      noteController: _noteController,
                    ),
                    SizedBox(height: 16.h),
                    PrimaryCtaButton(
                      label: S().homeServiceHoursCta,
                      onPressed: () =>
                          context.push(Routes.barberHomeServiceHoursScreen),
                    ),
                    SizedBox(height: 10.h),
                    PrimaryCtaButton(
                      label: S().homeServiceRequestsTitle,
                      onPressed: () =>
                          context.push(Routes.barberHomeServiceRequestsScreen),
                    ),
                  ],
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
      ),
    );
  }
}
