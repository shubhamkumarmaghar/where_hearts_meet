
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static late NotificationDetails notificationDetails;
  static late FlutterLocalNotificationsPlugin pluginInstance;

  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    pluginInstance = FlutterLocalNotificationsPlugin();
    notificationDetails = await setUpForLocalNotification(pluginInstance);

    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      log('APNS Token :: $apnsToken');
    } else if (Platform.isAndroid) {
      final androidToken = await FirebaseMessaging.instance.getToken();
      log('Android Token :: $androidToken');
    }
  }

  static Future<NotificationDetails> setUpForLocalNotification(
      FlutterLocalNotificationsPlugin pluginInstance) async {
    var init = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        ));
    pluginInstance.initialize(init);

    AndroidNotificationDetails androidSpec = const AndroidNotificationDetails(
      'ch_id',
      'ch_name',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );
    const AndroidNotificationChannel androidChannel =
    AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        playSound: true);
    await pluginInstance
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    pluginInstance
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails platformSpec = NotificationDetails(
      android: androidSpec,
      iOS: iosNotificationDetails,
    );
    return platformSpec;
  }

  static void onMessage({required RemoteMessage message}) async {
    if (Platform.isAndroid) {
      await pluginInstance.show(
          0, message.data['title'], message.data['body'], notificationDetails);
    }
  }

  static void onOpenedNotification({required RemoteMessage message}) {
    final routeName = message.data['navigation'];
    if (routeName != null && routeName != '') {
      int showId = int.tryParse(message.data["id"]) ?? 0;
      onNavigation(routeName: routeName, showId: showId);
    }
  }

  static void onInitialNotification({RemoteMessage? message}) {
    if (message == null) {
      return;
    }
    final routeName = message.data['navigation'];
    if (routeName != null && routeName != '') {
      int showId = int.tryParse(message.data["id"]) ?? 0;
      onNavigation(routeName: routeName, showId: showId);
    }
  }

  static void onNavigation({required String routeName, required int showId}) {

  }
}
