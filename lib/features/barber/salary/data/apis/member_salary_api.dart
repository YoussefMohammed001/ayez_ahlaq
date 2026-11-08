import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../domain/entities/salary_type.dart';

class MemberSalaryApi {
  final NetworkService _networkService;

  MemberSalaryApi(this._networkService);

  Future<Either<Failure, dynamic>> getMine({String? month}) {
    return _networkService.getData(
      endPoint: EndPoints.barberSalary,
      queryParameters: {'month': ?month},
    );
  }

  Future<Either<Failure, dynamic>> getOf(int memberId, {String? month}) {
    return _networkService.getData(
      endPoint: EndPoints.barberTeamSalary(memberId),
      queryParameters: {'month': ?month},
    );
  }

  Future<Either<Failure, dynamic>> set(
    int memberId, {
    required SalaryType type,
    required double amount,
  }) {
    return _networkService.putData(
      endPoint: EndPoints.barberTeamSalary(memberId),
      data: {'type': type.wireName, 'amount': amount},
    );
  }

  Future<Either<Failure, dynamic>> clear(int memberId) {
    return _networkService.deleteData(
      endPoint: EndPoints.barberTeamSalary(memberId),
    );
  }
}
