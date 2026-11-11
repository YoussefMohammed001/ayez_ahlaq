import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/session/session_scope.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/current_attendance.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/presentation/manager/member_attendance_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/attendance/presentation/manager/member_attendance_state.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/presentation/manager/merchant_notifications_state.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/fulfilment_type.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/order_status.dart';
import 'package:ayez_ahlaq/features/merchant/orders/domain/entities/purchase_order.dart';
import 'package:ayez_ahlaq/features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/orders/presentation/manager/merchant_orders_state.dart';
import 'package:ayez_ahlaq/features/merchant/orders/presentation/widgets/order_card.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/merchant_product.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/product_image_source.dart';
import 'package:ayez_ahlaq/features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/products/presentation/manager/merchant_products_state.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale_status.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/manager/sales_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/manager/sales_state.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/domain/sub_merchant_tab.dart';
import 'package:ayez_ahlaq/features/merchant/sub_merchant/presentation/pages/sub_merchant_home_screen.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_merchant_member_state.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_state.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Attendance extends Cubit<MemberAttendanceState>
    implements MemberAttendanceCubit {
  _Attendance(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Orders extends Cubit<MerchantOrdersState>
    implements MerchantOrdersCubit {
  _Orders(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Products extends Cubit<MerchantProductsState>
    implements MerchantProductsCubit {
  _Products(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Schedule extends Cubit<MyScheduleState> implements MyScheduleCubit {
  _Schedule(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Notifications extends Cubit<MerchantNotificationsState>
    implements MerchantNotificationsCubit {
  _Notifications(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Sales extends Cubit<SalesState> implements SalesCubit {
  _Sales(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Member extends Cubit<MyMerchantMemberState>
    implements MyMerchantMemberCubit {
  _Member(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

PurchaseOrder _order(int id, OrderStatus status) => PurchaseOrder(
  id: id,
  code: 'PO-$id',
  shopName: 'shop',
  barberName: 'barber',
  items: const [],
  subtotal: 100,
  orderDiscount: 0,
  total: 100,
  status: status,
  fulfilmentType: FulfilmentType.pickupAtBranch,
  nextStatuses: const [],
  deliveryFee: 0,
  grandTotal: 100,
);

MerchantProduct _product(int id, String name, int stock) => MerchantProduct(
  id: id,
  name: name,
  price: 10,
  effectivePrice: 10,
  minOrderQty: 1,
  active: true,
  totalStock: stock,
  imageSource: ProductImageSource.none,
  imageIds: const [],
);

MerchantMember _member({required bool canSell}) => MerchantMember(
  id: 1,
  merchantId: 6,
  name: 'Sub',
  phoneNumber: '01077777701',
  active: true,
  mustChangePassword: false,
  permissions: MerchantMemberPermissions(canSell: canSell),
);

AttendanceShift _shift() => AttendanceShift(
  id: 1,
  barberId: 1,
  barberName: 'Sub',
  checkInAt: DateTime(2026, 11, 11, 9),
  checkOutAt: null,
  durationMinutes: 0,
  status: AttendanceStatus.open,
  checkInDistanceMeters: null,
  adjustNote: null,
);

class _Data {
  final MemberAttendanceState attendance;
  final MerchantOrdersState orders;
  final MerchantProductsState products;
  final MyScheduleState schedule;
  final SalesState sales;
  final bool canSell;

  const _Data({
    this.attendance = const MemberAttendanceState(),
    this.orders = const MerchantOrdersState(),
    this.products = const MerchantProductsState(),
    this.schedule = const MyScheduleState(),
    this.sales = const SalesState(),
    this.canSell = false,
  });
}

Future<List<SubMerchantTab>> _open(WidgetTester tester, _Data data) async {
  SharedPreferences.setMockInitialValues({
    PreferencesKeys.merchantAccountKind.name: 'subMerchant',
  });
  await sl.reset();
  SessionScope.reset();
  sl.registerSingleton(
    PreferencesStorage(await SharedPreferences.getInstance()),
  );
  final member = _Member(
    MyMerchantMemberState(
      status: MyMemberStatus.success,
      member: _member(canSell: data.canSell),
    ),
  );
  sl.registerFactory<MyMerchantMemberCubit>(() => member);
  addTearDown(SessionScope.reset);

  tester.view.physicalSize = const Size(1200, 3600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final opened = <SubMerchantTab>[];

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider<MyMerchantMemberCubit>.value(value: member),
          BlocProvider<MemberAttendanceCubit>.value(
            value: _Attendance(data.attendance),
          ),
          BlocProvider<MerchantOrdersCubit>.value(value: _Orders(data.orders)),
          BlocProvider<MerchantProductsCubit>.value(
            value: _Products(data.products),
          ),
          BlocProvider<MyScheduleCubit>.value(value: _Schedule(data.schedule)),
          BlocProvider<MerchantNotificationsCubit>.value(
            value: _Notifications(const MerchantNotificationsState()),
          ),
          BlocProvider<SalesCubit>.value(value: _Sales(data.sales)),
        ],
        child: MaterialApp(
          theme: lightTheme,
          home: SubMerchantHomeScreen(onGoTo: opened.add),
        ),
      ),
    ),
  );
  await tester.pump();
  return opened;
}

void main() {
  testWidgets('with no hours set the hours card is not shown', (tester) async {
    await _open(
      tester,
      _Data(
        schedule: MyScheduleState(
          status: MyScheduleStatus.success,
          days: [for (var day = 0; day < 7; day++) WorkingDay.closed(day)],
        ),
      ),
    );

    expect(find.text(S().subHomeScheduleTitle), findsNothing);
  });

  testWidgets('lists only the three latest orders and an empty note', (
    tester,
  ) async {
    await _open(
      tester,
      _Data(
        orders: MerchantOrdersState(
          status: OrdersStatus.success,
          orders: [
            for (var id = 1; id <= 5; id++) _order(id, OrderStatus.delivered),
          ],
        ),
      ),
    );

    expect(find.byType(OrderCard), findsNWidgets(3));
    expect(find.text(S().seeAll), findsOneWidget);
  });

  testWidgets('with no orders at all it says so instead of an empty gap', (
    tester,
  ) async {
    await _open(
      tester,
      const _Data(orders: MerchantOrdersState(status: OrdersStatus.success)),
    );

    expect(find.text(S().subHomeNoOrders), findsOneWidget);
    expect(find.byType(OrderCard), findsNothing);
  });

  testWidgets('while nothing has loaded it shows placeholders only', (
    tester,
  ) async {
    await _open(tester, const _Data());

    expect(find.text(S().subHomeAttendanceTitle), findsOneWidget);
    expect(find.text(S().subHomePendingLabel), findsOneWidget);
    expect(find.text('...'), findsOneWidget);
    expect(find.text('-'), findsNWidgets(2));
    expect(find.text(S().subHomeLatestOrders), findsNothing);
    expect(find.text(S().subHomeScheduleTitle), findsNothing);
    expect(find.text(S().subHomeLowStockTitle), findsNothing);
    expect(find.text(S().subHomeSalesTitle), findsNothing);
  });

  testWidgets('shows the shift, orders, hours and low stock once loaded', (
    tester,
  ) async {
    final now = DateTime.now();
    await _open(
      tester,
      _Data(
        attendance: MemberAttendanceState(
          status: MemberAttendanceStatus.success,
          current: CurrentAttendance(
            shift: _shift(),
            config: const AttendanceConfig.none(),
          ),
          fetchedAt: now,
        ),
        orders: MerchantOrdersState(
          status: OrdersStatus.success,
          orders: [
            _order(1, OrderStatus.pending),
            _order(2, OrderStatus.pending),
            _order(3, OrderStatus.accepted),
            _order(4, OrderStatus.delivered),
          ],
        ),
        products: MerchantProductsState(
          status: ProductsStatus.success,
          products: [
            _product(1, 'Wax', 2),
            _product(2, 'Gel', 0),
            _product(3, 'Comb', 40),
          ],
        ),
        schedule: MyScheduleState(
          status: MyScheduleStatus.success,
          days: [
            for (var day = 0; day < 7; day++)
              WorkingDay(
                dayOfWeek: day,
                isOpen: true,
                openTime: '09:00:00',
                closeTime: '17:00:00',
              ),
          ],
        ),
      ),
    );

    expect(find.textContaining(S().attendanceOnShift), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text(S().subHomeLatestOrders), findsOneWidget);
    expect(find.text(S().scheduleTimeRange('09:00', '17:00')), findsOneWidget);
    expect(find.text(S().subHomeLowStockLine('Wax', '2')), findsOneWidget);
    expect(find.text(S().subHomeLowStockOut('Gel')), findsOneWidget);
    expect(find.textContaining('Comb'), findsNothing);
    expect(find.text(S().subHomeSalesTitle), findsNothing);
  });

  testWidgets('says so when attendance is off and no order needs an answer', (
    tester,
  ) async {
    await _open(
      tester,
      _Data(
        attendance: MemberAttendanceState(
          status: MemberAttendanceStatus.success,
          current: const CurrentAttendance(
            shift: null,
            config: AttendanceConfig.none(),
            enabled: false,
          ),
          fetchedAt: DateTime.now(),
        ),
        orders: MerchantOrdersState(
          status: OrdersStatus.success,
          orders: [_order(1, OrderStatus.delivered)],
        ),
      ),
    );

    expect(find.text(S().subHomeAttendanceDisabled), findsOneWidget);
    expect(find.text('0'), findsNWidgets(2));
  });

  testWidgets('asks to check in when attendance is on and no shift is open', (
    tester,
  ) async {
    await _open(
      tester,
      _Data(
        attendance: MemberAttendanceState(
          status: MemberAttendanceStatus.success,
          current: const CurrentAttendance.none(),
          fetchedAt: DateTime.now(),
        ),
      ),
    );

    expect(find.text(S().subHomeAttendanceNotStarted), findsOneWidget);
  });

  testWidgets('the sales card appears only with permission and sums today', (
    tester,
  ) async {
    final today = DateTime.now();
    await _open(
      tester,
      _Data(
        canSell: true,
        sales: SalesState(
          status: SalesStatus.success,
          sales: [
            Sale(
              id: 1,
              code: 'MS-1',
              subtotal: 120,
              discount: 0,
              total: 120,
              status: SaleStatus.done,
              items: const [],
              createdAt: today,
            ),
            Sale(
              id: 2,
              code: 'MS-2',
              subtotal: 80,
              discount: 0,
              total: 80,
              status: SaleStatus.done,
              items: const [],
              createdAt: today,
            ),
            Sale(
              id: 3,
              code: 'MS-3',
              subtotal: 900,
              discount: 0,
              total: 900,
              status: SaleStatus.cancelled,
              items: const [],
              createdAt: today,
            ),
          ],
        ),
      ),
    );

    expect(find.text(S().subHomeSalesTitle), findsOneWidget);
    expect(
      find.text(S().subHomeSalesSummary('2', S().currencyEgp('200'))),
      findsOneWidget,
    );
    expect(find.text(S().newSaleTitle), findsOneWidget);
  });

  testWidgets('tapping a card jumps to its tab', (tester) async {
    final opened = await _open(
      tester,
      _Data(
        orders: MerchantOrdersState(
          status: OrdersStatus.success,
          orders: [_order(1, OrderStatus.pending)],
        ),
        products: MerchantProductsState(
          status: ProductsStatus.success,
          products: [_product(1, 'Wax', 2)],
        ),
      ),
    );

    await tester.tap(find.text(S().subHomeAttendanceTitle));
    await tester.tap(find.text(S().subHomePendingLabel));
    await tester.tap(find.text(S().subHomeLowStockTitle));

    expect(opened, [
      SubMerchantTab.attendance,
      SubMerchantTab.orders,
      SubMerchantTab.products,
    ]);
  });
}
