import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/delivery_location_field.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../../domain/entities/home_service_shop.dart';
import '../manager/home_service_request_form_cubit.dart';
import '../manager/home_service_request_form_state.dart';

class HomeServiceRequestScreen extends StatefulWidget {
  final HomeServiceShop shop;

  const HomeServiceRequestScreen({super.key, required this.shop});

  @override
  State<HomeServiceRequestScreen> createState() =>
      _HomeServiceRequestScreenState();
}

class _HomeServiceRequestScreenState extends State<HomeServiceRequestScreen> {
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  double? _lat;
  double? _lng;

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (_addressController.text.trim().isEmpty || _lat == null || _lng == null) {
      showError(S().homeServiceAddressRequired);
      return;
    }

    final cubit = context.read<HomeServiceRequestFormCubit>();
    await cubit.submit(
      shopId: widget.shop.id,
      address: _addressController.text.trim(),
      lat: _lat!,
      lng: _lng!,
      note: _noteController.text.trim().isNotEmpty
          ? _noteController.text.trim()
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceRequestTitle),
      body: BlocConsumer<HomeServiceRequestFormCubit, HomeServiceRequestFormState>(
        listener: (context, state) {
          if (state.status == HomeServiceRequestFormStatus.success) {
            context.go(
              Routes.successScreen,
              extra: SuccessScreenArgs(
                message: S().homeServiceRequestCreated,
                doneRoute: Routes.customerShell,
              ),
            );
          }
          if (state.status == HomeServiceRequestFormStatus.failure &&
              state.errorMessage != null) {
            showError(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  children: [
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shop.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            S().homeServiceStartingPrice(
                              widget.shop.homeServicePrice.toString(),
                            ),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: context.semantic.accentStrong,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SectionTitle(title: S().orderDeliveryAddressLabel),
                    DeliveryLocationField(
                      addressController: _addressController,
                      latitude: _lat,
                      longitude: _lng,
                      onLocationPicked: (lat, lng) =>
                          setState(() {
                            _lat = lat;
                            _lng = lng;
                          }),
                    ),
                    SectionTitle(title: S().homeServiceNoteLabel),
                    AppTextField(
                      controller: _noteController,
                      hint: S().homeServiceRequestNoteHint,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: PrimaryCtaButton(
                  label: S().homeServiceSubmitRequest,
                  isLoading: state.status == HomeServiceRequestFormStatus.submitting,
                  onPressed: () => _submit(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
