import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerNotificationsApi {
  final NetworkService _networkService;

  CustomerNotificationsApi(this._networkService);

  Future<Either<Failure, dynamic>> getNotifications({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.customerNotification,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getUnseenCount() {
    return _networkService.getData(
      endPoint: EndPoints.customerNotificationUnseenCount,
    );
  }

  Future<Either<Failure, dynamic>> markAllSeen() {
    return _networkService.putData(endPoint: EndPoints.customerNotificationSeen);
  }

  Future<Either<Failure, dynamic>> markSeen(int id) {
    return _networkService.putData(
      endPoint: EndPoints.customerNotificationSeenById(id),
    );
  }

  Future<Either<Failure, dynamic>> markClicked(int id) {
    return _networkService.putData(
      endPoint: EndPoints.customerNotificationClickedById(id),
    );
  }
}
