import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/walk_in_option.dart';
import '../repos/i_barber_booking_repo.dart';

class GetWalkInOptionsUseCase {
  final IBarberBookingRepo _repo;

  GetWalkInOptionsUseCase(this._repo);

  Future<Either<Failure, List<WalkInOption>>> call() => _repo.getWalkInOptions();
}
