import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/di/services_locator.dart';
import 'package:ayez_ahlaq/core/notifications/notification_payload.dart';
import 'package:ayez_ahlaq/core/notifications/notification_router.dart';
import 'package:ayez_ahlaq/features/merchant/device_token/presentation/services/merchant_device_token_sync_service.dart';
import 'package:ayez_ahlaq/features/merchant/notifications/domain/use_cases/mark_notification_clicked_use_case.dart'
    as merchant;
import 'package:ayez_ahlaq/features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import 'package:ayez_ahlaq/features/barber/device_token/presentation/services/barber_device_token_sync_service.dart';
import 'package:ayez_ahlaq/features/barber/notifications/domain/use_cases/mark_notification_clicked_use_case.dart'
    as barber;
import 'package:ayez_ahlaq/features/customer/device_token/presentation/services/customer_device_token_sync_service.dart';
import 'package:ayez_ahlaq/features/customer/notifications/domain/use_cases/mark_customer_notification_clicked_use_case.dart';
import 'package:ayez_ahlaq/features/customer/notifications/presentation/manager/customer_notifications_cubit.dart';
import 'package:ayez_ahlaq/features/barber/notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../shared/user_type.dart';
import '../routes/app_routes.dart';
import '../session/session_scope.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  log('📥 Background Message: ${message.data}');
}

class NotificationNavigator {
  NotificationNavigator._();

  static NotificationNavigator? _instance;

  factory NotificationNavigator() {
    return _instance ??= NotificationNavigator._();
  }

  RemoteMessage? _pendingInitialMessage;

  Future<void> init() async {
    _pendingInitialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
  }

  RemoteMessage? consumePendingInitialMessage() {
    final message = _pendingInitialMessage;
    _pendingInitialMessage = null;
    return message;
  }
}

class NotificationService {
  static const int _apnsMaxAttempts = 25;
  static const Duration _apnsRetryDelay = Duration(milliseconds: 200);

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
    description: 'This channel is used for important notifications.',
  );

  late BuildContext _context;
  late NotificationNavigator _navigator;
  Timer? _pollingTimer;

  NotificationService();

  void setContext(BuildContext context) {
    _context = context;
  }

  void setNavigator(NotificationNavigator navigator) {
    _navigator = navigator;
  }

  Future<void> setupNotifications() async {
    await _requestPermissions();
    await _saveFcmToken();
    await _setForegroundNotificationOptions();
    await _createAndroidChannel();
    await _initLocalNotification();
    await _navigator.init();
    _configureNotificationListeners();
  }

  Future<void> _requestPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('🔔 Notification permission: ${settings.authorizationStatus}');
  }

  Future<String?> _waitForApnsToken() async {
    for (var attempt = 0; attempt < _apnsMaxAttempts; attempt++) {
      final token = await FirebaseMessaging.instance.getAPNSToken();
      if (token != null) return token;
      await Future.delayed(_apnsRetryDelay);
    }
    return null;
  }

  Future<void> _saveFcmToken() async {
    if (Platform.isIOS) {
      final apnsToken = await _waitForApnsToken();
      if (apnsToken == null) return;
      log('🍎 APNs token: $apnsToken');
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('✅ FCM Token: $fcmToken');

    if (fcmToken == null || await UserHelpers.isGuest()) return;

    try {
      switch (UserHelpers.userType) {
        case UserType.merchant:
          await sl<MerchantDeviceTokenSyncService>().syncToken(fcmToken);
          break;
        case UserType.barber:
          await sl<BarberDeviceTokenSyncService>().syncToken(fcmToken);
          break;
        case UserType.customer:
          await sl<CustomerDeviceTokenSyncService>().syncToken(fcmToken);
          break;
      }
    } catch (e, st) {
      log('Error syncing device token: $e\n$st');
    }
  }

  Future<void> _setForegroundNotificationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _createAndroidChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? response) {
        if (response?.payload != null) {
          final messageMap = json.decode(response!.payload!);
          final message = RemoteMessage.fromMap(messageMap);
          handleNotificationTap(message);
        }
      },
    );
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          enableVibration: true,
          playSound: true,
          icon: '@drawable/ic_notification',
          color: const Color(0xFFC6982F),
          importance: Importance.high,
          priority: Priority.max,
        );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: json.encode(message.toMap()),
    );
  }

  void _configureNotificationListeners() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('📲 onMessage: ${message.data}');
      try {
        await _showNotification(message);
      } catch (e, st) {
        log('Error showing local notification: $e\n$st');
      }
      _refreshUnseenNotifications();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🚀 onMessageOpenedApp: ${message.data}');
      handleNotificationTap(message);
      _refreshUnseenNotifications();
    });
  }

  Future<void> _refreshUnseenNotifications() async {
    try {
      int unseenCount;
      switch (UserHelpers.userType) {
        case UserType.merchant:
          final cubit = SessionScope.cubit<MerchantNotificationsCubit>();
          await cubit.refreshUnseenCount();
          unseenCount = cubit.state.unseenCount;
          break;
        case UserType.barber:
          final cubit = SessionScope.cubit<BarberNotificationsCubit>();
          await cubit.refreshUnseenCount();
          unseenCount = cubit.state.unseenCount;
          break;
        case UserType.customer:
          final cubit = SessionScope.cubit<CustomerNotificationsCubit>();
          await cubit.refreshUnseenCount();
          unseenCount = cubit.state.unseenCount;
          break;
      }
      await _updateBadge(unseenCount);
    } catch (e, st) {
      log("Error refreshing unseen notifications: $e\n$st");
    }
  }

  Future<void> _updateBadge(int count) async {
    if (!await AppBadgePlus.isSupported()) return;
    await AppBadgePlus.updateBadge(count);
  }

  void handleNotificationTap(RemoteMessage message) {
    final navKey = rootNavigatorKey;
    final notificationId = int.tryParse(message.data['id']?.toString() ?? '');
    if (notificationId != null) {
      try {
        switch (UserHelpers.userType) {
          case UserType.merchant:
            sl<merchant.MarkNotificationClickedUseCase>().call(
              notificationId,
            );
            break;
          case UserType.barber:
            sl<barber.MarkNotificationClickedUseCase>().call(notificationId);
            break;
          case UserType.customer:
            sl<MarkCustomerNotificationClickedUseCase>().call(notificationId);
            break;
        }
      } catch (e, st) {
        log('Error marking notification clicked: $e\n$st');
      }
    }

    final payload = NotificationPayload.fromMap(message.data);

    Future.delayed(const Duration(milliseconds: 500), () {
      final context = navKey.currentContext;
      if (context == null) {
        safePrint("NavigatorKey.currentContext");
        return;
      }
      sl<NotificationRouter>().route(
        type: payload.type,
        typeId: payload.typeId,
        role: UserHelpers.userType,
        context: context,
      );
    });
  }
}
