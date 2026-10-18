import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../barber/hours/data/models/working_day_model.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_shop.dart';
import '../models/home_service_request_model.dart';
import '../models/home_service_shop_model.dart';

class CustomerHomeServiceMappers {
  const CustomerHomeServiceMappers._();

  static List<HomeServiceShop> shops(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map(
          (json) => HomeServiceShopModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  static List<WorkingDay> hours(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static List<HomeServiceRequest> requests(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map(
          (json) =>
              HomeServiceRequestModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  static Either<Failure, HomeServiceRequest> request(dynamic response) {
    return requireDataMap(response).map(HomeServiceRequestModel.fromJson);
  }
}
