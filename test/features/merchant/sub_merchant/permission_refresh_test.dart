import 'dart:async';

import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/secure_storage/secure_storage.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/network/interceptors/authorization_interceptor.dart';
import 'package:ayez_ahlaq/core/session/session_events.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/presentation/helpers/refresh_throttle.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/presentation/widgets/sub_merchant_permission_refresher.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/repos/i_merchant_member_self_repo.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/change_my_merchant_password_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/get_my_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeSelfRepo extends Fake implements IMerchantMemberSelfRepo {
  var calls = 0;

  @override
  Future<Either<Failure, MerchantMember>> getMe() async {
    calls++;
    return const Right(
      MerchantMember(
        id: 1,
        merchantId: 6,
        name: 'Sub',
        phoneNumber: '01077777701',
        active: true,
        mustChangePassword: false,
        permissions: MerchantMemberPermissions(canSell: true),
      ),
    );
  }
}

class _FakeStorage extends Fake implements SecureStorage {
  @override
  Future<String?> read(SecureStorageKeys key) async => null;
}

class _SilentHandler extends ErrorInterceptorHandler {
  _SilentHandler() {
    future.then((_) {}, onError: (_) {});
  }
}

DioException _error(int status, {bool withToken = true}) => DioException(
  requestOptions: RequestOptions(
    path: '/x',
    headers: {if (withToken) 'Authorization': 'Bearer t'},
  ),
  response: Response(
    requestOptions: RequestOptions(path: '/x'),
    statusCode: status,
  ),
);

void main() {
  group('RefreshThrottle', () {
    test('lets the first call through and blocks the burst after it', () {
      var now = DateTime(2026, 11, 11, 10);
      final throttle = RefreshThrottle(clock: () => now);

      expect(throttle.tryAcquire(), isTrue);
      now = now.add(const Duration(seconds: 2));
      expect(throttle.tryAcquire(), isFalse);
      now = now.add(const Duration(seconds: 3));
      expect(throttle.tryAcquire(), isTrue);
    });

    test('a blocked call does not push the window forward', () {
      var now = DateTime(2026, 11, 11, 10);
      final throttle = RefreshThrottle(clock: () => now);

      throttle.tryAcquire();
      now = now.add(const Duration(seconds: 4));
      throttle.tryAcquire();
      now = now.add(const Duration(seconds: 1));

      expect(throttle.tryAcquire(), isTrue);
    });
  });

  group('AuthorizationInterceptor', () {
    late List<String> events;
    late AuthorizationInterceptor interceptor;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      events = [];
      interceptor = AuthorizationInterceptor(
        _FakeStorage(),
        PreferencesStorage(await SharedPreferences.getInstance()),
        () => events.add('unauthorized'),
        () => events.add('forbidden'),
      );
    });

    void send(DioException error, [AuthorizationInterceptor? target]) {
      (target ?? interceptor).onError(error, _SilentHandler());
    }

    test('a 403 with a token reports forbidden only', () {
      send(_error(403));

      expect(events, ['forbidden']);
    });

    test('a 401 with a token reports unauthorized only', () {
      send(_error(401));

      expect(events, ['unauthorized']);
    });

    test('a 403 without a token and other errors report nothing', () {
      send(_error(403, withToken: false));
      send(_error(500));
      send(_error(404));

      expect(events, isEmpty);
    });

    test('the forbidden callback is optional', () {
      final plain = AuthorizationInterceptor(
        _FakeStorage(),
        interceptor.preferences,
        () {},
      );

      expect(() => send(_error(403), plain), returnsNormally);
    });
  });

  group('SubMerchantPermissionRefresher', () {
    late _FakeSelfRepo repo;
    late StreamController<String> events;
    late DateTime now;
    late MyMerchantMemberCubit cubit;

    Future<void> pump(WidgetTester tester) async {
      repo = _FakeSelfRepo();
      events = StreamController<String>.broadcast();
      now = DateTime(2026, 11, 11, 10);
      cubit = MyMerchantMemberCubit(
        GetMyMerchantMemberUseCase(repo),
        ChangeMyMerchantPasswordUseCase(repo),
      );
      addTearDown(events.close);
      addTearDown(cubit.close);

      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: MaterialApp(
            home: SubMerchantPermissionRefresher(
              events: events.stream,
              throttle: RefreshThrottle(clock: () => now),
              child: const SizedBox(),
            ),
          ),
        ),
      );
    }

    testWidgets('a forbidden event reloads the member record', (tester) async {
      await pump(tester);

      events.add(SessionEvents.forbidden);
      await tester.pumpAndSettle();

      expect(repo.calls, 1);
      expect(cubit.state.member?.canSell, isTrue);
    });

    testWidgets('other session events are ignored', (tester) async {
      await pump(tester);

      events.add(SessionEvents.unauthorized);
      await tester.pumpAndSettle();

      expect(repo.calls, 0);
    });

    testWidgets('returning to the app reloads it', (tester) async {
      await pump(tester);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pumpAndSettle();
      expect(repo.calls, 0);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(repo.calls, 1);
    });

    testWidgets('a burst of 403s reloads once, a later one reloads again', (
      tester,
    ) async {
      await pump(tester);

      events.add(SessionEvents.forbidden);
      events.add(SessionEvents.forbidden);
      events.add(SessionEvents.forbidden);
      await tester.pumpAndSettle();
      expect(repo.calls, 1);

      now = now.add(const Duration(seconds: 6));
      events.add(SessionEvents.forbidden);
      await tester.pumpAndSettle();
      expect(repo.calls, 2);
    });

    testWidgets('nothing is reloaded after the screen is gone', (tester) async {
      await pump(tester);
      await tester.pumpWidget(const SizedBox());

      events.add(SessionEvents.forbidden);
      await tester.pumpAndSettle();

      expect(repo.calls, 0);
    });
  });
}
