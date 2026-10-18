import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/location_picker_field.dart';
import '../../domain/entities/home_service_shop.dart';
import 'home_service_date_time_row.dart';
import 'home_service_locked_date_time_row.dart';
import 'home_service_request_shop_card.dart';

class HomeServiceRequestFormFields extends StatelessWidget {
  final HomeServiceShop? shop;
  final String? retryShopName;
  final TextEditingController addressController;
  final TextEditingController noteController;
  final double? lat;
  final double? lng;
  final ValueChanged<double> onLatChanged;
  final ValueChanged<double> onLngChanged;
  final DateTime? date;
  final TimeOfDay? time;
  final bool showDateTimePicker;
  final ValueChanged<DateTime> onDatePicked;
  final ValueChanged<TimeOfDay> onTimePicked;

  const HomeServiceRequestFormFields({
    super.key,
    required this.shop,
    this.retryShopName,
    required this.addressController,
    required this.noteController,
    required this.lat,
    required this.lng,
    required this.onLatChanged,
    required this.onLngChanged,
    required this.date,
    required this.time,
    this.showDateTimePicker = true,
    required this.onDatePicked,
    required this.onTimePicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        HomeServiceRequestShopCard(shop: shop, retryShopName: retryShopName),
        SectionTitle(title: S().orderDeliveryAddressLabel),
        LocationPickerField(
          addressController: addressController,
          latitude: lat,
          longitude: lng,
          onLocationPicked: (pickedLat, pickedLng) {
            onLatChanged(pickedLat);
            onLngChanged(pickedLng);
          },
        ),
        SectionTitle(title: S().homeServiceDateTimeLabel),
        if (showDateTimePicker)
          HomeServiceDateTimeRow(
            date: date,
            time: time,
            onDatePicked: onDatePicked,
            onTimePicked: onTimePicked,
          )
        else if (date != null && time != null)
          HomeServiceLockedDateTimeRow(date: date!, time: time!),
        SectionTitle(title: S().homeServiceNoteLabel),
        AppTextField(
          controller: noteController,
          hint: S().homeServiceRequestNoteHint,
          maxLines: 3,
        ),
      ],
    );
  }
}
