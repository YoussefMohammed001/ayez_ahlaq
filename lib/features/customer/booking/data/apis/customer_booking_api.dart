import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class CustomerBookingApi {
  final NetworkService _networkService;

  CustomerBookingApi(this._networkService);

  Future<Either<Failure, dynamic>> getSlots({
    required int shopId,
    required int serviceTypeId,
    required String date,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.customerBookingSlots,
      queryParameters: {
        'shopId': shopId,
        'serviceTypeId': serviceTypeId,
        'date': date,
      },
    );
  }

  Future<Either<Failure, dynamic>> createBooking(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.customerBooking,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> getBookings() {
    return _networkService.getData(endPoint: EndPoints.customerBooking);
  }

  Future<Either<Failure, dynamic>> getBooking(int id) {
    return _networkService.getData(endPoint: EndPoints.customerBookingById(id));
  }

  Future<Either<Failure, dynamic>> cancelBooking(int id) {
    return _networkService.putData(endPoint: EndPoints.customerBookingCancel(id));
  }

  Future<Either<Failure, dynamic>> rateBooking(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.customerRating,
      data: body,
    );
  }
}
