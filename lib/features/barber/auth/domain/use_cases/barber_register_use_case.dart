import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/barber_register_request.dart';
import '../repos/i_barber_auth_repo.dart';

class BarberRegisterUseCase {
  final IBarberAuthRepo _repo;

  BarberRegisterUseCase(this._repo);

  Future<Either<Failure, Unit>> call(BarberRegisterRequest request) =>
      _repo.register(request);
}
