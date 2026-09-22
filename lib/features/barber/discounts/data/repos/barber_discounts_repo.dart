import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/barber_discount.dart';
import '../../domain/repos/i_barber_discounts_repo.dart';
import '../apis/barber_discounts_api.dart';
import '../models/barber_discount_model.dart';
import '../requests/barber_discount_request.dart';

class BarberDiscountsRepo implements IBarberDiscountsRepo {
  final BarberDiscountsApi _api;

  BarberDiscountsRepo(this._api);

  @override
  Future<Either<Failure, List<BarberDiscount>>> getDiscounts() async {
    final result = await _api.getDiscounts();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, BarberDiscount>> getDiscountById(int id) async {
    final result = await _api.getDiscountById(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, BarberDiscount>> createDiscount(
    BarberDiscountRequest request,
  ) async {
    final result = await _api.createDiscount(request);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, BarberDiscount>> updateDiscount(
    int id,
    BarberDiscountRequest request,
  ) async {
    final result = await _api.updateDiscount(id, request);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> closeDiscount(int id) async {
    final result = await _api.closeDiscount(id);
    return result.map((_) => unit);
  }

  List<BarberDiscount> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<BarberDiscount>(
          (e) => BarberDiscountModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Either<Failure, BarberDiscount> _mapOne(dynamic response) {
    return requireDataMap(response).map(BarberDiscountModel.fromJson);
  }
}
