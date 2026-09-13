import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/create_own_service_use_case.dart';
import '../../domain/use_cases/delete_own_service_use_case.dart';
import '../../domain/use_cases/get_own_services_use_case.dart';
import 'own_services_state.dart';

class OwnServicesCubit extends Cubit<OwnServicesState> {
  final GetOwnServicesUseCase _getOwnServices;
  final CreateOwnServiceUseCase _createOwnService;
  final DeleteOwnServiceUseCase _deleteOwnService;

  OwnServicesCubit(
    this._getOwnServices,
    this._createOwnService,
    this._deleteOwnService,
  ) : super(const OwnServicesState());

  Future<void> loadOwnServices() async {
    emit(state.copyWith(status: OwnServicesStatus.loading));

    final result = await _getOwnServices();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OwnServicesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (services) => emit(
        state.copyWith(status: OwnServicesStatus.success, services: services),
      ),
    );
  }

  Future<bool> createOwnService(String name, String description) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createOwnService(name, description);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
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

  Future<void> deleteOwnService(int id) async {
    final previous = state.services;

    emit(
      state.copyWith(
        isDeleting: true,
        services: state.services.where((s) => s.id != id).toList(),
      ),
    );

    final result = await _deleteOwnService(id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isDeleting: false,
          services: previous,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(isDeleting: false)),
    );
  }
}
