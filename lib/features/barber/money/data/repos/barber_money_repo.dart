import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_entry.dart';
import '../../domain/entities/money_entry_page.dart';
import '../../domain/entities/money_frequency.dart';
import '../../domain/entities/money_item.dart';
import '../../domain/entities/money_occurrence.dart';
import '../../domain/entities/money_summary.dart';
import '../../domain/repos/i_barber_money_repo.dart';
import '../apis/barber_money_api.dart';
import '../models/money_entry_model.dart';
import '../models/money_entry_page_model.dart';
import '../models/money_item_model.dart';
import '../models/money_occurrence_model.dart';
import '../models/money_summary_model.dart';

class BarberMoneyRepo implements IBarberMoneyRepo {
  final BarberMoneyApi _api;

  BarberMoneyRepo(this._api);

  @override
  Future<Either<Failure, List<MoneyItem>>> getItems() async {
    final result = await _api.getItems();
    return result.map((r) => _list(r, MoneyItemModel.fromJson));
  }

  @override
  Future<Either<Failure, MoneyItem>> createItem({
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
  }) async {
    final result = await _api.createItem(
      _itemBody(description, amount, direction, frequency, dayOfWeek, dayOfMonth),
    );
    return result.flatMap((r) => requireDataMap(r).map(MoneyItemModel.fromJson));
  }

  @override
  Future<Either<Failure, MoneyItem>> updateItem({
    required int id,
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    required bool active,
  }) async {
    final body = _itemBody(description, amount, direction, frequency, dayOfWeek, dayOfMonth)
      ..['active'] = active;
    final result = await _api.updateItem(id, body);
    return result.flatMap((r) => requireDataMap(r).map(MoneyItemModel.fromJson));
  }

  @override
  Future<Either<Failure, void>> deleteItem(int id) async {
    return (await _api.deleteItem(id)).map((_) {});
  }

  @override
  Future<Either<Failure, MoneyEntryPage>> getEntries({
    required int page,
    required int size,
  }) async {
    final result = await _api.getEntries(page: page, size: size);
    return result.flatMap((r) => requireDataMap(r).map(MoneyEntryPageModel.fromJson));
  }

  @override
  Future<Either<Failure, MoneyEntry>> createEntry({
    required String description,
    required int amount,
    required MoneyDirection direction,
    DateTime? entryDate,
  }) async {
    final result = await _api.createEntry({
      'description': description,
      'amount': amount,
      'direction': direction.toApi(),
      if (entryDate != null)
        'entryDate': entryDate.toIso8601String().split('T').first,
    });
    return result.flatMap((r) => requireDataMap(r).map(MoneyEntryModel.fromJson));
  }

  @override
  Future<Either<Failure, MoneySummary>> getSummary() async {
    final result = await _api.getSummary();
    return result.flatMap((r) => requireDataMap(r).map(MoneySummaryModel.fromJson));
  }

  @override
  Future<Either<Failure, List<MoneyOccurrence>>> getPendingOccurrences() async {
    final result = await _api.getPendingOccurrences();
    return result.map((r) => _list(r, MoneyOccurrenceModel.fromJson));
  }

  @override
  Future<Either<Failure, void>> confirmOccurrence({
    required int id,
    String? description,
    int? amount,
  }) async {
    final result = await _api.confirmOccurrence(id, {
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
    });
    return result.map((_) {});
  }

  @override
  Future<Either<Failure, void>> dismissOccurrence(int id) async {
    return (await _api.dismissOccurrence(id)).map((_) {});
  }

  Map<String, dynamic> _itemBody(
    String description,
    int amount,
    MoneyDirection direction,
    MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
  ) {
    return {
      'description': description,
      'amount': amount,
      'direction': direction.toApi(),
      'frequency': frequency.toApi(),
      if (dayOfWeek != null) 'dayOfWeek': dayOfWeek,
      if (dayOfMonth != null) 'dayOfMonth': dayOfMonth,
    };
  }

  List<T> _list<T>(dynamic response, T Function(Map<String, dynamic>) fromJson) {
    final data = response['data'] as List? ?? const [];
    return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }
}
