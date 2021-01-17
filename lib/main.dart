import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/screens/home_user_page/home_page_screen.dart';
import 'package:donate_blood/screens/welcome/welcome_screen.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/donation_type_translation.dart';
import 'generated/l10n.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  //print("Handling a background message ${message.messageId}");
  bool isAccountActivityNotifications = true;
  SharedPreferences.getInstance().then((value) {
    if (value.getBool("accountActivityNotifications") != null)
      isAccountActivityNotifications =
          value.getBool("accountActivityNotifications");
  });
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
                  " ml, " +
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
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    enableVibration: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  ///Shared preferences init (locale information)
  String locale;
  bool isEventNotifications = true;
  await SharedPreferences.getInstance().then((value) {
    if (value.getString("delegate") != null)
      locale = value.getString("delegate");
    if (value.getBool("eventNotifications") != null)
      isEventNotifications = value.getBool("eventNotifications");
  });

  if (isEventNotifications) {
    FirebaseMessaging.instance.subscribeToTopic('event');
  } else {
    FirebaseMessaging.instance.unsubscribeFromTopic('event');
  }

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp(locale));
  if (kDebugMode)
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}

class MyApp extends StatelessWidget {
  final String locale;

  MyApp(this.locale);

  @override
  Widget build(BuildContext context) {
    User user = Auth().getCurrentUser();
    return Provider<Repository>(
      create: (_) => Repository(FirebaseFirestore.instance),
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: locale != null ? Locale(locale) : null,
        debugShowCheckedModeBanner: false,
        title: "Donate Blood",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: (user != null && user.uid.isNotEmpty)
            ? HomePageScreen()
            : WelcomeScreen(),
      ),
    );
  }
}
