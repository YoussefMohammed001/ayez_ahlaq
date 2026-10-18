import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/home_service_date_time_parsing.dart';
import '../widgets/home_service_date_time_row.dart';
import 'home_service_shop_list_args.dart';

class HomeServiceDateTimeScreen extends StatefulWidget {
  const HomeServiceDateTimeScreen({super.key});

  @override
  State<HomeServiceDateTimeScreen> createState() =>
      _HomeServiceDateTimeScreenState();
}

class _HomeServiceDateTimeScreenState extends State<HomeServiceDateTimeScreen> {
  DateTime? _date;
  TimeOfDay? _time;

  void _continue() {
    final date = _date;
    final time = _time;
    if (date == null || time == null) {
      showError(S().homeServiceDateTimeRequired);
      return;
    }
    if (HomeServiceDateTimeParsing.combine(
      date,
      time,
    ).isBefore(DateTime.now())) {
      showError(S().homeServiceDateTimeMustBeFuture);
      return;
    }

    context.push(
      Routes.customerHomeServiceShopListScreen,
      extra: HomeServiceShopListArgs(
        date: DateFormat('yyyy-MM-dd', 'en').format(date),
        time: HomeServiceDateTimeRow.formatTime(time),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceShopListTitle),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S().homeServiceDateTimeStepTitle,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            Text(
              S().homeServiceDateTimeStepSubtitle,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 20.h),
            HomeServiceDateTimeRow(
              date: _date,
              time: _time,
              onDatePicked: (value) => setState(() => _date = value),
              onTimePicked: (value) => setState(() => _time = value),
            ),
            const Spacer(),
            PrimaryCtaButton(label: S().continueLabel, onPressed: _continue),
          ],
        ),
      ),
    );
  }
}
