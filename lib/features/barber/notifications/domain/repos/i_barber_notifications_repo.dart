import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/notification_page.dart';

abstract class IBarberNotificationsRepo {
  Future<Either<Failure, NotificationPage>> getNotifications({
    required int page,
    required int size,
  });

  Future<Either<Failure, int>> getUnseenCount();

  Future<Either<Failure, Unit>> markAllSeen();

  Future<Either<Failure, Unit>> markSeen(int id);

  Future<Either<Failure, Unit>> markClicked(int id);
}
