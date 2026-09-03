import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/notification_page.dart';
import '../../domain/repos/i_merchant_notifications_repo.dart';
import '../apis/merchant_notifications_api.dart';
import '../models/notification_page_model.dart';

class MerchantNotificationsRepo implements IMerchantNotificationsRepo {
  final MerchantNotificationsApi _api;

  MerchantNotificationsRepo(this._api);

  @override
  Future<Either<Failure, NotificationPage>> getNotifications({
    required int page,
    required int size,
  }) async {
    final result = await _api.getNotifications(page: page, size: size);
    return result.map(
      (response) => NotificationPageModel.fromJson(
        response['data'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  Future<Either<Failure, int>> getUnseenCount() async {
    final result = await _api.getUnseenCount();
    return result.map(
      (response) =>
          ((response['data'] as Map<String, dynamic>)['count'] as num?)
              ?.toInt() ??
          0,
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
