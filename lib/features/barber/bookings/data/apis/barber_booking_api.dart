import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/booking_status.dart';

class BarberBookingApi {
  final NetworkService _networkService;

  BarberBookingApi(this._networkService);

  Future<Either<Failure, dynamic>> getBookings({
    String? date,
    BookingStatus? status,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberBooking,
      queryParameters: {
        if (date != null) 'date': date,
        if (status != null) 'status': status.toApi(),
      },
    );
  }

  Future<Either<Failure, dynamic>> getPendingBookings() {
    return _networkService.getData(endPoint: EndPoints.barberBookingPending);
  }

  Future<Either<Failure, dynamic>> getQueue(String date) {
    return _networkService.getData(
      endPoint: EndPoints.barberBookingQueue,
      queryParameters: {'date': date},
    );
  }

  Future<Either<Failure, dynamic>> getBooking(int id) {
    return _networkService.getData(
      endPoint: EndPoints.barberBookingById(id),
    );
  }

  Future<Either<Failure, dynamic>> confirmBooking(int id) {
    return _networkService.putData(
      endPoint: EndPoints.barberBookingConfirm(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> rejectBooking(int id, String reason) {
    return _networkService.putData(
      endPoint: EndPoints.barberBookingReject(id),
      data: {'reason': reason},
    );
  }

  Future<Either<Failure, dynamic>> advanceStatus(int id, BookingStatus status) {
    return _networkService.putData(
      endPoint: EndPoints.barberBookingStatus(id),
      data: {'status': status.toApi()},
    );
  }

  Future<Either<Failure, dynamic>> createWalkIn({
    int? barberId,
    required int serviceTypeId,
    int? haircutStyleId,
    required String customerName,
    required String customerPhone,
    required String paymentMethod,
    String? note,
    required List<Map<String, dynamic>> addons,
  }) {
    return _networkService.postData(
      endPoint: EndPoints.barberBookingWalkin,
      data: {
        'barberId': barberId,
        'serviceTypeId': serviceTypeId,
        'haircutStyleId': haircutStyleId,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'paymentMethod': paymentMethod,
        'note': note,
        'addons': addons,
      },
    );
  }
}
