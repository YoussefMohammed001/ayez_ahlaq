import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import '../manager/home_service_request_form_cubit.dart';
import '../manager/home_service_request_form_state.dart';
import '../widgets/home_service_date_time_parsing.dart';
import '../widgets/home_service_date_time_row.dart';
import '../widgets/home_service_request_form_fields.dart';
import 'home_service_request_args.dart';
import 'home_service_request_submit_listener.dart';

class HomeServiceRequestScreen extends StatefulWidget {
  final HomeServiceRequestArgs? requestArgs;
  final HomeServiceRequest? retryRequest;

  const HomeServiceRequestScreen({
    super.key,
    this.requestArgs,
    this.retryRequest,
  });

  @override
  State<HomeServiceRequestScreen> createState() =>
      _HomeServiceRequestScreenState();
}

class _HomeServiceRequestScreenState extends State<HomeServiceRequestScreen> {
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  double? _lat;
  double? _lng;
  DateTime? _date;
  TimeOfDay? _time;

  bool get _isRetry => widget.retryRequest != null;

  bool get _anyNearby =>
      widget.retryRequest?.anyNearby ?? widget.requestArgs?.shop == null;

  @override
  void initState() {
    super.initState();
    context.read<HomeServiceRequestFormCubit>().reset();
    final retry = widget.retryRequest;
    if (retry != null) {
      _addressController.text = retry.address;
      _noteController.text = retry.note ?? '';
      _lat = retry.lat;
      _lng = retry.lng;
      _date = HomeServiceDateTimeParsing.tryParseDate(retry.date);
      _time = HomeServiceDateTimeParsing.tryParseTime(retry.time);
      return;
    }

    final args = widget.requestArgs?.dateTimeArgs;
    if (args != null) {
      _date = HomeServiceDateTimeParsing.tryParseDate(args.date);
      _time = HomeServiceDateTimeParsing.tryParseTime(args.time);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (_addressController.text.trim().isEmpty ||
        _lat == null ||
        _lng == null) {
      showError(S().homeServiceAddressRequired);
      return;
    }
    if (_date == null || _time == null) {
      showError(S().homeServiceDateTimeRequired);
      return;
    }
    if (HomeServiceDateTimeParsing.combine(
      _date!,
      _time!,
    ).isBefore(DateTime.now())) {
      showError(S().homeServiceDateTimeMustBeFuture);
      return;
    }

    final cubit = context.read<HomeServiceRequestFormCubit>();
    await cubit.submit(
      retryRequestId: widget.retryRequest?.id,
      shopId: widget.requestArgs?.shop?.id ?? widget.retryRequest?.shopId,
      anyNearby: _anyNearby,
      address: _addressController.text.trim(),
      lat: _lat!,
      lng: _lng!,
      note: _noteController.text.trim().isNotEmpty
          ? _noteController.text.trim()
          : null,
      date: DateFormat('yyyy-MM-dd', 'en').format(_date!),
      time: HomeServiceDateTimeRow.formatTime(_time!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceRequestTitle),
      body:
          BlocConsumer<
            HomeServiceRequestFormCubit,
            HomeServiceRequestFormState
          >(
            listener: (context, state) =>
                handleHomeServiceFormSubmitted(context, state),
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: HomeServiceRequestFormFields(
                      shop: widget.requestArgs?.shop,
                      retryShopName: _anyNearby
                          ? null
                          : widget.retryRequest?.shopName,
                      addressController: _addressController,
                      noteController: _noteController,
                      lat: _lat,
                      lng: _lng,
                      onLatChanged: (value) => setState(() => _lat = value),
                      onLngChanged: (value) => setState(() => _lng = value),
                      date: _date,
                      time: _time,
                      showDateTimePicker: _isRetry,
                      onDatePicked: (value) => setState(() => _date = value),
                      onTimePicked: (value) => setState(() => _time = value),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                    child: PrimaryCtaButton(
                      label: S().homeServiceSubmitRequest,
                      isLoading:
                          state.status ==
                          HomeServiceRequestFormStatus.submitting,
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
