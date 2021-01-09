import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/bottom_nav_screen.dart';
import 'package:donate_blood/components/donation_type_translation.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
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

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
    });*/

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> data = message.data;

      if (data != null) {
        switch (data['type']) {
          case 'new_event':
            if (message.from.contains('event')) {
              DateTime eventDate = new DateTime.fromMillisecondsSinceEpoch(
                  int.parse(data['eventDate']));
              flutterLocalNotificationsPlugin.show(
                  message.hashCode,
                  S.current.newEventNotificationTitle,
                  new DateFormat("d MMMM y, H:mm").format(eventDate) +
                      ', ' +
                      data['location'],
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      channel.description,
                      icon: 'notification_icon',
                    ),
                  ));
            }
            break;
          case 'new_donation':
            if (isAccountActivityNotifications) {
              DateTime donationDate = new DateTime.fromMillisecondsSinceEpoch(
                  int.parse(data['donationDate']));
              String donationType =
                  DonationType().getTranslationOfBlood(data['donationType']);
              flutterLocalNotificationsPlugin.show(
                  message.hashCode,
                  S.current.newDonationNotificationTitle,
                  donationType +
                      ", " +
                      data['amount'] +
                      "ml, " +
                      DateFormat("d MMMM y, H:mm").format(donationDate),
                  NotificationDetails(
                    android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      channel.description,
                      icon: 'notification_icon',
                    ),
                  ));
            }
            break;
          default:
            {}
        }
        /*  if (isAccountActivityNotifications || message.from.contains('event')){
          DateTime eventDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(data['eventDate']));
          flutterLocalNotificationsPlugin.show(
              message.hashCode,
              S.current.newEventNotificationTitle,
              new DateFormat("d MMMM y, H:mm").format(eventDate) + ', ' + data['location'],
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: 'notification_icon',
                ),
              ));
        }*/
      }
    });
  }
}
