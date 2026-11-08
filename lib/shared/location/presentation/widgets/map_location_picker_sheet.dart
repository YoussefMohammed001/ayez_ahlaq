import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/services_locator.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/geo_point.dart';
import '../../domain/entities/picked_location.dart';
import '../manager/map_location_picker_cubit.dart';
import '../manager/map_location_picker_state.dart';
import 'map/app_map_controller.dart';
import 'map_picker_header.dart';
import 'map_picker_map_card.dart';
import 'map_picker_selected_card_builder.dart';

class MapLocationPickerSheet extends StatefulWidget {
  final PickedLocation? initial;

  const MapLocationPickerSheet({super.key, this.initial});

  static Future<PickedLocation?> show(
    BuildContext context, {
    PickedLocation? initial,
  }) {
    return showModalBottomSheet<PickedLocation>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) => BlocProvider(
        create: (_) => sl<MapLocationPickerCubit>(),
        child: MapLocationPickerSheet(initial: initial),
      ),
    );
  }

  @override
  State<MapLocationPickerSheet> createState() => _MapLocationPickerSheetState();
}

class _MapLocationPickerSheetState extends State<MapLocationPickerSheet> {
  final _mapController = AppMapController();
  final _searchController = TextEditingController();
  late GeoPoint _center;

  MapLocationPickerCubit get _cubit => context.read<MapLocationPickerCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.start(widget.initial);
    _center = _cubit.state.target;
    if (!_cubit.hasInitialLocation) _goToMyLocation(silent: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _goToMyLocation({bool silent = false}) async {
    final location = await _cubit.locateMe(silent: silent);
    if (location != null) _mapController.animateTo(location);
  }

  Future<void> _confirm() async {
    final place = _cubit.picked;
    final label = place.address.isNotEmpty ? place.address : place.name;

    final confirmed = await showConfirmDialog(
      context,
      title: S().confirmLocation,
      message: label.isEmpty ? S().confirmLocationNoAddress : label,
      icon: Icons.place_rounded,
      isDestructive: false,
    );

    if (confirmed && mounted) context.pop(_cubit.confirm());
  }

  Future<void> _submitSearch(String query) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final point = await _cubit.searchAndSelect(query);
    if (point == null) return;
    _center = point;
    _mapController.animateTo(point);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: BlocListener<MapLocationPickerCubit, MapLocationPickerState>(
          listenWhen: (previous, current) =>
              current.errorMessage != null &&
              current.errorMessage != previous.errorMessage,
          listener: (_, state) => showError(state.errorMessage!),
          child: Column(
            children: [
              MapPickerHeader(
                title: S().mapPickerTitle,
                onClose: () => context.pop(),
              ),
              10.hSpace,

              Divider(height: 1, color: context.colorScheme.outline),
              _buildSearchField(),
              Expanded(child: _buildMapArea()),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                child: MapPickerSelectedCardBuilder(
                  onLocateMe: _goToMyLocation,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child:
                    BlocBuilder<MapLocationPickerCubit, MapLocationPickerState>(
                      builder: (_, state) => PrimaryCtaButton(
                        label: S().confirmLocation,
                        isLoading:
                            state.isResolvingPlace ||
                            state.isSearching ||
                            state.isLocating,
                        onPressed: _cubit.canConfirm ? _confirm : null,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: AppSearchField(
        controller: _searchController,
        hintText: S().searchPlaceHint,
        onSubmitted: _submitSearch,
      ),
    );
  }

  Widget _buildMapArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: MapPickerMapCard(
        initialTarget: _center,
        initialZoom: _cubit.hasInitialLocation ? 16 : 14,
        controller: _mapController,
        onCameraMove: (point) {
          _center = point;
          _cubit.onCameraMove(point);
        },
        onCameraIdle: () => _cubit.onCameraIdle(_center),
        onMyLocation: _goToMyLocation,
      ),
    );
  }
}
