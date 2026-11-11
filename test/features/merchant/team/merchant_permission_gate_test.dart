import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/session/session_scope.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/repos/i_merchant_member_self_repo.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/change_my_merchant_password_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/get_my_merchant_member_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/widgets/merchant_permission_gate.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeSelfRepo extends Fake implements IMerchantMemberSelfRepo {
  MerchantMemberPermissions permissions = const MerchantMemberPermissions();

  @override
  Future<Either<Failure, MerchantMember>> getMe() async => Right(
    MerchantMember(
      id: 4000014,
      merchantId: 6,
      name: 'Sub',
      phoneNumber: '01077777701',
      active: true,
      mustChangePassword: false,
      permissions: permissions,
    ),
  );
}

Future<void> _useAccountKind(String? kind) async {
  SharedPreferences.setMockInitialValues({
    if (kind != null) PreferencesKeys.merchantAccountKind.name: kind,
  });
  await sl.reset();
  sl.registerSingleton(
    PreferencesStorage(await SharedPreferences.getInstance()),
  );
}

Widget _gate() => MaterialApp(
  home: MerchantPermissionGate(
    allows: MerchantPermissionGate.canManageProducts,
    builder: (_, allowed) => Text(allowed ? 'allowed' : 'denied'),
  ),
);

void main() {
  tearDown(SessionScope.reset);

  testWidgets('the owner always passes without loading anything', (
    tester,
  ) async {
    await _useAccountKind('owner');

    await tester.pumpWidget(_gate());

    expect(find.text('allowed'), findsOneWidget);
  });

  testWidgets('a sub-merchant is denied until the permission is granted', (
    tester,
  ) async {
    await _useAccountKind('subMerchant');
    final repo = _FakeSelfRepo();
    sl.registerFactory(
      () => MyMerchantMemberCubit(
        GetMyMerchantMemberUseCase(repo),
        ChangeMyMerchantPasswordUseCase(repo),
      ),
    );
    final cubit = SessionScope.cubit<MyMerchantMemberCubit>();

    await tester.pumpWidget(_gate());
    expect(find.text('denied'), findsOneWidget);

    await cubit.load();
    await tester.pumpAndSettle();
    expect(find.text('denied'), findsOneWidget);

    repo.permissions = const MerchantMemberPermissions(canManageProducts: true);
    await cubit.load();
    await tester.pumpAndSettle();
    expect(find.text('allowed'), findsOneWidget);

    repo.permissions = const MerchantMemberPermissions(canSell: true);
    await cubit.load();
    await tester.pumpAndSettle();
    expect(find.text('denied'), findsOneWidget);
  });
}
