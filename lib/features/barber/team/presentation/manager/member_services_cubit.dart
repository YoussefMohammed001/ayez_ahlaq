import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../../domain/use_cases/create_member_service_use_case.dart';
import '../../domain/use_cases/delete_member_service_use_case.dart';
import '../../domain/use_cases/get_member_service_catalog_use_case.dart';
import '../../domain/use_cases/get_member_services_use_case.dart';
import '../../domain/use_cases/update_member_service_use_case.dart';
import 'member_services_state.dart';

class MemberServicesCubit extends Cubit<MemberServicesState> {
  final GetMemberServiceCatalogUseCase _getCatalog;
  final GetMemberServicesUseCase _getServices;
  final CreateMemberServiceUseCase _createService;
  final UpdateMemberServiceUseCase _updateService;
  final DeleteMemberServiceUseCase _deleteService;

  MemberServicesCubit(
    this._getCatalog,
    this._getServices,
    this._createService,
    this._updateService,
    this._deleteService,
  ) : super(const MemberServicesState());

  Future<void> loadServices(int memberId) async {
    emit(
      state.copyWith(status: MemberServicesStatus.loading, memberId: memberId),
    );

    final catalogResult = await _getCatalog(memberId);

    await catalogResult.fold(
      (failure) async => emit(
        state.copyWith(
          status: MemberServicesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (catalog) async {
        final servicesResult = await _getServices(memberId);

        servicesResult.fold(
          (failure) => emit(
            state.copyWith(
              status: MemberServicesStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (services) => emit(
            state.copyWith(
              status: MemberServicesStatus.success,
              catalog: catalog,
              services: services,
            ),
          ),
        );
      },
    );
  }

  Future<bool> createService(BarberService service) async {
    final memberId = state.memberId;
    if (memberId == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _createService(memberId, service);

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
    final memberId = state.memberId;
    if (memberId == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _updateService(memberId, service);

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
    final memberId = state.memberId;
    if (memberId == null) return;

    final previous = state.services;

    emit(state.copyWith(services: state.services.where((s) => s.id != id).toList()));

    final result = await _deleteService(memberId, id);

    result.leftMap(
      (failure) => emit(
        state.copyWith(services: previous, errorMessage: failure.message),
      ),
    );
  }
}
