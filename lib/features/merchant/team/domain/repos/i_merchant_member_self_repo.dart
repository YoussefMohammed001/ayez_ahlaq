import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../entities/merchant_member.dart';

abstract class IMerchantMemberSelfRepo {
  Future<Either<Failure, MerchantMember>> getMe();

  Future<Either<Failure, List<WorkingDay>>> getMyHours();

  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  );
}
