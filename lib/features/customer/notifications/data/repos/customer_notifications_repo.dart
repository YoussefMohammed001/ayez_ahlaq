import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/customer_notification_page.dart';
import '../../domain/repos/i_customer_notifications_repo.dart';
import '../apis/customer_notifications_api.dart';
import '../models/customer_notification_page_model.dart';

class CustomerNotificationsRepo implements ICustomerNotificationsRepo {
  final CustomerNotificationsApi _api;

  CustomerNotificationsRepo(this._api);

  @override
  Future<Either<Failure, CustomerNotificationPage>> getNotifications({
    required int page,
    required int size,
  }) async {
    final result = await _api.getNotifications(page: page, size: size);
    return result.map(
      (response) => CustomerNotificationPageModel.fromJson(
        response['data'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  Future<Either<Failure, int>> getUnseenCount() async {
    final result = await _api.getUnseenCount();
    return result.map(
      (response) =>
          ((response['data'] as Map<String, dynamic>)['count'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  Future<Either<Failure, Unit>> markAllSeen() async {
    final result = await _api.markAllSeen();
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> markSeen(int id) async {
    final result = await _api.markSeen(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> markClicked(int id) async {
    final result = await _api.markClicked(id);
    return result.map((_) => unit);
  }
}
