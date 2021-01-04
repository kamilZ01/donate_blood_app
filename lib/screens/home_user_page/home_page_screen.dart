import 'package:donate_blood/Screens/bottom_nav_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavScreen(),
    );
  }

  @override
  void initState() {
    super.initState();

    bool isAccountActivityNotifications = true;
    SharedPreferences.getInstance().then((value) {
      if (value.getBool("accountActivityNotifications") != null)
        isAccountActivityNotifications =
            value.getBool("accountActivityNotifications");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        if (isAccountActivityNotifications || message.from.contains('event'))
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'notification_icon',
                ),
              ));
      }
    });
  }
}
