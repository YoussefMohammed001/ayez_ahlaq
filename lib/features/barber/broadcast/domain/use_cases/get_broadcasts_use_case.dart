import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/broadcast_page.dart';
import '../repos/i_barber_broadcast_repo.dart';

class GetBroadcastsUseCase {
  final IBarberBroadcastRepo _repo;

  GetBroadcastsUseCase(this._repo);

  Future<Either<Failure, BroadcastPage>> call({
    required int page,
    required int size,
  }) => _repo.list(page: page, size: size);
}
