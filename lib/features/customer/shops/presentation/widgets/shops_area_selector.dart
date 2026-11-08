import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/location/presentation/widgets/map_location_picker_sheet.dart';
import '../manager/customer_shops_cubit.dart';
import '../manager/customer_shops_state.dart';
import 'shops_filter_header.dart';

class ShopsAreaSelector extends StatelessWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final EdgeInsetsGeometry? padding;

  const ShopsAreaSelector({
    super.key,
    this.searchController,
    this.onSearchChanged,
    this.padding,
  });

  Future<void> _pickPlace(BuildContext context) async {
    final cubit = context.read<CustomerShopsCubit>();
    final picked = await MapLocationPickerSheet.show(
      context,
      initial: cubit.state.area?.toPicked(),
    );
    if (picked != null) await cubit.chooseArea(picked);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerShopsCubit>();

    return BlocBuilder<CustomerShopsCubit, CustomerShopsState>(
      buildWhen: (a, b) => a.mode != b.mode || a.area != b.area,
      builder: (context, state) => ShopsFilterHeader(
        mode: state.mode,
        areaLabel: state.area?.label,
        onMyLocation: cubit.useMyLocation,
        onPickPlace: () => _pickPlace(context),
        searchController: searchController,
        onSearchChanged: onSearchChanged,
        padding: padding,
      ),
    );
  }
}
