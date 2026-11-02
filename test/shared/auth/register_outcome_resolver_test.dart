import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/shared/auth/data/register_outcome_resolver.dart';
import 'package:ayez_ahlaq/shared/auth/domain/entities/auth_session.dart';
import 'package:ayez_ahlaq/shared/auth/domain/entities/register_outcome.dart';

void main() {
  const resolver = RegisterOutcomeResolver();
  const session = AuthSession(
    token: 'jwt',
    role: 'MERCHANT',
    actorId: 1,
    displayName: 'x',
  );

  late List<AuthSession> saved;
  late int loginCalls;

  setUp(() {
    saved = [];
    loginCalls = 0;
  });

  Future<Either<Failure, RegisterOutcome>> run(
    Either<Failure, dynamic> response, {
    Either<Failure, AuthSession> loginResult = const Right(session),
  }) => resolver.resolve(
    response: response,
    saveSession: (value) async => saved.add(value),
    login: () async {
      loginCalls++;
      return loginResult;
    },
  );

  test('activated with a token saves the session without logging in', () async {
    final result = await run(
      const Right({
        'data': {
          'activated': true,
          'auth': {
            'token': 'jwt',
            'role': 'CUSTOMER',
            'actorId': 7,
            'displayName': 'Sami',
          },
        },
      }),
    );

    expect(result, const Right(RegisterOutcome.signedIn));
    expect(saved.single.token, 'jwt');
    expect(saved.single.actorId, 7);
    expect(loginCalls, 0);
  });

  test('activated without a token logs in with the credentials', () async {
    final result = await run(
      const Right({
        'data': {'activated': true, 'auth': null},
      }),
    );

    expect(result, const Right(RegisterOutcome.signedIn));
    expect(loginCalls, 1);
    expect(saved, isEmpty);
  });

  test('activated without a token surfaces a failed login', () async {
    final failure = Failure('bad', 401, const {});
    final result = await run(
      const Right({
        'data': {'activated': true, 'auth': null},
      }),
      loginResult: Left(failure),
    );

    expect(result, Left(failure));
  });

  test('not activated asks for the OTP', () async {
    final result = await run(
      const Right({
        'data': {'activated': false, 'auth': null, 'otpTtlSeconds': 300},
      }),
    );

    expect(result, const Right(RegisterOutcome.otpRequired));
    expect(loginCalls, 0);
    expect(saved, isEmpty);
  });

  test('propagates a register failure', () async {
    final failure = Failure('taken', 409, const {});

    expect(await run(Left(failure)), Left(failure));
  });
}
