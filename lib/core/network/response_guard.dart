import 'package:dartz/dartz.dart';
import '../../generated/l10n.dart';
import '../error/failure.dart';

Either<Failure, Map<String, dynamic>> requireDataMap(dynamic response) {
  final data = response['data'];
  if (data is Map<String, dynamic>) return Right(data);
  return Left(Failure(S().somethingWentWrong, null, const {}));
}
