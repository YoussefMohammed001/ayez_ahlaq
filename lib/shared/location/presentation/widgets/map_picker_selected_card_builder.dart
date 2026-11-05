import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/map_location_picker_cubit.dart';
import '../manager/map_location_picker_state.dart';
import 'map_picker_selected_card.dart';

class MapPickerSelectedCardBuilder extends StatelessWidget {
  final VoidCallback onLocateMe;

  const MapPickerSelectedCardBuilder({super.key, required this.onLocateMe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapLocationPickerCubit, MapLocationPickerState>(
      buildWhen: (previous, current) =>
          previous.place != current.place ||
          previous.isResolvingPlace != current.isResolvingPlace ||
          previous.isMoving != current.isMoving ||
          previous.isSearching != current.isSearching ||
          previous.isLocating != current.isLocating,
      builder: (_, state) => MapPickerSelectedCard(
        place: state.place,
        isResolving:
            state.isResolvingPlace || state.isSearching || state.isMoving,
        isLocating: state.isLocating,
        onLocateMe: onLocateMe,
      ),
    );
  }
}
