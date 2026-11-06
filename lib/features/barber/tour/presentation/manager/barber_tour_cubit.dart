import 'package:flutter_bloc/flutter_bloc.dart';
import 'barber_tour_state.dart';

class BarberTourCubit extends Cubit<BarberTourState> {
  BarberTourCubit() : super(const BarberTourState());

  void requestTour() =>
      emit(BarberTourState(requestCount: state.requestCount + 1));
}
