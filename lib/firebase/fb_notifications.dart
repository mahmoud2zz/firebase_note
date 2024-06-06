import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_note_provider/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Messages${remoteMessage.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  static Future<void> initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    if (Platform.isAndroid) {
      channel = AndroidNotificationChannel(
          'firebase_note_provider', 'flutter Android Notifictions Channal',
          description:
              'This channel will receive notfications spcific to flutter app',
          importance: Importance.high,
          enableLights: true,
          enableVibration: true,
          ledColor: Colors.orange,
          playSound: true);

      localNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> requestNotificationsPermissions() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      announcement: false,
      criticalAlert: false,
    );
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('GRANT Permissions');
    } else {
      print('Permissions Denied');
    }
  }

  void initializeForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Received${message.messageId}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification?.android;
      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: 'launch_background')));
      }
    });
  }

//   GENERAL ANDROID && IOS

  void mangeNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _controlNotificationNavigation(message.data);
    });
  }

  void _controlNotificationNavigation(Map<String, dynamic> data) {
    if (data['page'] != null) {
      switch (data['page']) {
        case 'products':
          var productId = data['id'];
          break;

        case 'settings':
          print('Navigation settings');
          break;

        case 'profile':
          print('Navigation profile');
      }
    }
  }
}
