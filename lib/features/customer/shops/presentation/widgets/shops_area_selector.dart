import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../shared/location/presentation/widgets/map_location_picker_sheet.dart';
import '../manager/customer_shops_cubit.dart';
import '../manager/customer_shops_state.dart';
import 'shops_area_bar.dart';

class ShopsAreaSelector extends StatelessWidget {
  const ShopsAreaSelector({super.key});

  Future<void> _choose(BuildContext context) async {
    final cubit = context.read<CustomerShopsCubit>();
    final picked = await MapLocationPickerSheet.show(
      context,
      initial: cubit.state.area?.toPicked(),
    );
    if (picked != null) await cubit.chooseArea(picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
      buildWhen: (a, b) => a.area != b.area,
      builder: (context, state) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
        child: ShopsAreaBar(
          label: state.area?.label,
          onChange: () => _choose(context),
          onUseMyLocation: context.read<CustomerShopsCubit>().useMyLocation,
        ),
      ),
    );
  }
}
