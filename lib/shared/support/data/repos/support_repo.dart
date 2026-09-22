import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/response_guard.dart';
import '../../domain/entities/support_info.dart';
import '../../domain/repos/i_support_repo.dart';
import '../apis/support_api.dart';
import '../models/support_info_model.dart';

class SupportRepo implements ISupportRepo {
  final SupportApi _api;

  SupportRepo(this._api);

  @override
  Future<Either<Failure, SupportInfo>> getSupportInfo() async {
    final result = await _api.getSupportInfo();
    return result.flatMap(_mapOne);
  }

  Either<Failure, SupportInfo> _mapOne(dynamic response) {
    return requireDataMap(response).map(SupportInfoModel.fromJson);
  }
}
