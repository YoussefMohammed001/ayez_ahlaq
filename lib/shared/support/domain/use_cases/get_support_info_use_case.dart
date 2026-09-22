import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/support_info.dart';
import '../repos/i_support_repo.dart';

class GetSupportInfoUseCase {
  final ISupportRepo _repo;

  GetSupportInfoUseCase(this._repo);

  Future<Either<Failure, SupportInfo>> call() => _repo.getSupportInfo();
}
