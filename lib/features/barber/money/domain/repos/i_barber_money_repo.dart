import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_direction.dart';
import '../entities/money_entry.dart';
import '../entities/money_entry_page.dart';
import '../entities/money_frequency.dart';
import '../entities/money_item.dart';
import '../entities/money_occurrence.dart';
import '../entities/money_summary.dart';

abstract class IBarberMoneyRepo {
  Future<Either<Failure, List<MoneyItem>>> getItems();

  Future<Either<Failure, MoneyItem>> createItem({
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
  });

  Future<Either<Failure, MoneyItem>> updateItem({
    required int id,
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    required bool active,
  });

  Future<Either<Failure, void>> deleteItem(int id);

  Future<Either<Failure, MoneyEntryPage>> getEntries({
    required int page,
    required int size,
  });

  Future<Either<Failure, MoneyEntry>> createEntry({
    required String description,
    required int amount,
    required MoneyDirection direction,
    DateTime? entryDate,
  });

  Future<Either<Failure, MoneySummary>> getSummary();

  Future<Either<Failure, List<MoneyOccurrence>>> getPendingOccurrences();

  Future<Either<Failure, void>> confirmOccurrence({
    required int id,
    String? description,
    int? amount,
  });

  Future<Either<Failure, void>> dismissOccurrence(int id);
}
