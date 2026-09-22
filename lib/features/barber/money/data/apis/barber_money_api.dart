import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberMoneyApi {
  final NetworkService _networkService;

  BarberMoneyApi(this._networkService);

  Future<Either<Failure, dynamic>> getItems() {
    return _networkService.getData(endPoint: EndPoints.barberMoneyItem);
  }

  Future<Either<Failure, dynamic>> createItem(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.barberMoneyItem,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> updateItem(int id, Map<String, dynamic> body) {
    return _networkService.putData(
      endPoint: EndPoints.barberMoneyItemById(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> deleteItem(int id) {
    return _networkService.deleteData(endPoint: EndPoints.barberMoneyItemById(id));
  }

  Future<Either<Failure, dynamic>> getEntries({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberMoneyEntry,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> createEntry(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.barberMoneyEntry,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> getSummary() {
    return _networkService.getData(endPoint: EndPoints.barberMoneySummary);
  }

  Future<Either<Failure, dynamic>> getPendingOccurrences() {
    return _networkService.getData(
      endPoint: EndPoints.barberMoneyOccurrencePending,
    );
  }

  Future<Either<Failure, dynamic>> confirmOccurrence(
    int id,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.barberMoneyOccurrenceConfirm(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> dismissOccurrence(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberMoneyOccurrenceDismiss(id),
      data: const {},
    );
  }
}
