import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantTeamApi {
  final NetworkService _networkService;

  MerchantTeamApi(this._networkService);

  Future<Either<Failure, dynamic>> getMembers({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantMember,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getMember(int id) {
    return _networkService.getData(endPoint: EndPoints.merchantMemberById(id));
  }

  Future<Either<Failure, dynamic>> addMember(Map<String, dynamic> body) {
    return _networkService.postData(
      endPoint: EndPoints.merchantMember,
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> updateMember(
    int id,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberById(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> setSalary(int id, double salary) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberSalary(id),
      data: {'salary': salary},
    );
  }

  Future<Either<Failure, dynamic>> updatePermissions(
    int id,
    Map<String, dynamic> body,
  ) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberPermissions(id),
      data: body,
    );
  }

  Future<Either<Failure, dynamic>> blockMember(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberBlock(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> activateMember(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberActivate(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> resetPassword(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantMemberResetPassword(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> deleteMember(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantMemberById(id),
    );
  }
}
