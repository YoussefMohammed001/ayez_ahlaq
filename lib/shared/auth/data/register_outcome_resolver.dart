import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/response_guard.dart';
import '../domain/entities/auth_session.dart';
import '../domain/entities/register_outcome.dart';
import 'models/register_response_model.dart';

class RegisterOutcomeResolver {
  const RegisterOutcomeResolver();

  Future<Either<Failure, RegisterOutcome>> resolve({
    required Either<Failure, dynamic> response,
    required Future<void> Function(AuthSession session) saveSession,
    required Future<Either<Failure, AuthSession>> Function() login,
  }) async {
    final parsed = response.flatMap(
      (body) => requireDataMap(body).map(RegisterResponseModel.fromJson),
    );

    return parsed.fold((failure) async => Left(failure), (model) async {
      final session = model.session;
      if (session != null) {
        await saveSession(session);
        return const Right(RegisterOutcome.signedIn);
      }
      if (model.activated) {
        final loggedIn = await login();
        return loggedIn.map((_) => RegisterOutcome.signedIn);
      }
      return const Right(RegisterOutcome.otpRequired);
    });
  }
}
