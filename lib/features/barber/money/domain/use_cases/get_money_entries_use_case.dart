import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_entry_page.dart';
import '../repos/i_barber_money_repo.dart';

class GetMoneyEntriesUseCase {
  final IBarberMoneyRepo _repo;

  GetMoneyEntriesUseCase(this._repo);

  Future<Either<Failure, MoneyEntryPage>> call({
    required int page,
    required int size,
  }) {
    return _repo.getEntries(page: page, size: size);
  }
}
