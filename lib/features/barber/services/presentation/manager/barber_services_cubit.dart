import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/use_cases/create_barber_service_use_case.dart';
import '../../domain/use_cases/delete_barber_service_use_case.dart';
import '../../domain/use_cases/get_barber_services_use_case.dart';
import '../../domain/use_cases/get_service_catalog_use_case.dart';
import '../../domain/use_cases/update_barber_service_use_case.dart';
import 'barber_services_state.dart';

class BarberServicesCubit extends Cubit<BarberServicesState> {
  final GetServiceCatalogUseCase _getCatalog;
  final GetBarberServicesUseCase _getServices;
  final CreateBarberServiceUseCase _createService;
  final UpdateBarberServiceUseCase _updateService;
  final DeleteBarberServiceUseCase _deleteService;

  BarberServicesCubit(
    this._getCatalog,
    this._getServices,
    this._createService,
    this._updateService,
    this._deleteService,
  ) : super(const BarberServicesState());

  Future<void> loadServices() async {
    emit(state.copyWith(status: BarberServicesStatus.loading));

    final catalogResult = await _getCatalog();

    await catalogResult.fold(
      (failure) async => emit(
        state.copyWith(
          status: BarberServicesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (catalog) async {
        final servicesResult = await _getServices();

        servicesResult.fold(
          (failure) => emit(
            state.copyWith(
              status: BarberServicesStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (services) => emit(
            state.copyWith(
              status: BarberServicesStatus.success,
              catalog: catalog,
              services: services,
            ),
          ),
        );
      },
    );
  }

  Future<bool> createService(BarberService service) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createService(service);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (created) {
        emit(
          state.copyWith(
            isSubmitting: false,
            services: [...state.services, created],
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateService(BarberService service) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateService(service);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            isSubmitting: false,
            services: [
              for (final s in state.services)
                if (s.id == updated.id) updated else s,
            ],
          ),
        );
        return true;
      },
    );
  }

  Future<void> deleteService(int id) async {
    final previous = state.services;

    emit(state.copyWith(services: state.services.where((s) => s.id != id).toList()));

    final result = await _deleteService(id);

    result.leftMap(
      (failure) => emit(
        state.copyWith(services: previous, errorMessage: failure.message),
      ),
    );
  }
}
