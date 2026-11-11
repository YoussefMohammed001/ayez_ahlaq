import 'package:ayez_ahlaq/core/di/modules/merchant_team_di.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/network/dio/network_service.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/member_hours_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_member_detail_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/merchant_team_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNetworkService extends Fake implements NetworkService {}

void main() {
  setUp(() async {
    await sl.reset();
    sl.registerSingleton<NetworkService>(FakeNetworkService());
    registerMerchantTeam();
  });

  test('every merchant team cubit resolves', () {
    expect(sl<MerchantTeamCubit>(), isA<MerchantTeamCubit>());
    expect(sl<MerchantMemberDetailCubit>(), isA<MerchantMemberDetailCubit>());
    expect(sl<MyMerchantMemberCubit>(), isA<MyMerchantMemberCubit>());
  });

  test('the member hours cubit is registered under the merchant name', () {
    final first = sl<MemberHoursCubit>(
      instanceName: merchantMemberHoursCubitName,
    );
    final second = sl<MemberHoursCubit>(
      instanceName: merchantMemberHoursCubitName,
    );

    expect(first, isA<MemberHoursCubit>());
    expect(first, isNot(same(second)));
  });
}
