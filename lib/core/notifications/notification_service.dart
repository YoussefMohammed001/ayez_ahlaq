import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'package:ayez_ahlaq/core/helpers/user_helpers.dart';
import 'package:ayez_ahlaq/core/di/services_locator.dart';
import 'package:ayez_ahlaq/core/notifications/notification_payload.dart';
import 'package:ayez_ahlaq/core/notifications/notification_router.dart';
import '../routes/app_routes.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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

  Future<void> _saveFcmToken() async {
    if (Platform.isIOS) {
      String? apnsToken;
      while (apnsToken == null) {
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        await Future.delayed(const Duration(milliseconds: 200));
      }
      log('🍎 APNs token: $apnsToken');
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('✅ FCM Token: $fcmToken');
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
        AndroidInitializationSettings('@mipmap/ic_launcher');

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

  void _showNotification(RemoteMessage message) async {
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
          icon: 'ic_notification',
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📲 onMessage: ${message.data}');
      if (message.notification == null) {
        _showNotification(message);
      }
      _refreshUnseenNotifications();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🚀 onMessageOpenedApp: ${message.data}');
      handleNotificationTap(message);
      _refreshUnseenNotifications();
    });
  }

  void _refreshUnseenNotifications() {
    try {
     // sl<UnseenCountCubit>().refresh();
    } catch (e, st) {
      log("Error refreshing unseen notifications: $e\n$st");
    }
  }

  void handleNotificationTap(RemoteMessage message) {
    final navKey = rootNavigatorKey;
    final notificationId = int.tryParse(message.data['id']?.toString() ?? '');
    if (notificationId != null) {
   //   sl<MarkOneClickedUseCase>().call(notificationId);
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
