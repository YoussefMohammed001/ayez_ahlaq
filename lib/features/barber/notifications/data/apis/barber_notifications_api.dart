import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberNotificationsApi {
  final NetworkService _networkService;

  BarberNotificationsApi(this._networkService);

  Future<Either<Failure, dynamic>> getNotifications({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberNotification,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getUnseenCount() {
    return _networkService.getData(
      endPoint: EndPoints.barberNotificationUnseenCount,
    );
  }

  Future<Either<Failure, dynamic>> markAllSeen() {
    return _networkService.putData(
      endPoint: EndPoints.barberNotificationSeen,
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> markSeen(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberNotificationSeenById(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> markClicked(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberNotificationClickedById(id),
      data: const {},
    );
  }
}
