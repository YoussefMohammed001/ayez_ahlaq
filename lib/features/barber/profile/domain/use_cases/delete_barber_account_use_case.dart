import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_profile_repo.dart';

class DeleteBarberAccountUseCase {
  final IBarberProfileRepo _repo;

  DeleteBarberAccountUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String password) =>
      _repo.deleteAccount(password);
}
