import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/support_info.dart';

abstract class ISupportRepo {
  Future<Either<Failure, SupportInfo>> getSupportInfo();
}
