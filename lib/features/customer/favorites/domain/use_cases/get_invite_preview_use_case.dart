import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_invite_preview.dart';
import '../repos/i_customer_favorites_repo.dart';

class GetInvitePreviewUseCase {
  final ICustomerFavoritesRepo _repo;

  GetInvitePreviewUseCase(this._repo);

  Future<Either<Failure, BarberInvitePreview>> call(String code) =>
      _repo.getInvitePreview(code);
}
