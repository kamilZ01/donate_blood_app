import 'dart:io';

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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
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

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

  String eventLocale = locale != null ? locale.toUpperCase() : Platform.localeName.substring(0,2).toUpperCase();
  if (isEventNotifications) {
    await FirebaseMessaging.instance.subscribeToTopic('event' + eventLocale);
  } else {
    await FirebaseMessaging.instance.unsubscribeFromTopic('event' + eventLocale);
  }

  runApp(MyApp(locale));
  if (kDebugMode)
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}

/*class App extends StatefulWidget {
  final String locale;
  App(this.locale);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

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
        locale: widget.locale != null ? Locale(widget.locale) : null,
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
}*/

class MyApp extends StatelessWidget {
  final String locale;

  MyApp(this.locale);

  // This widget is the root of your application.
  //AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate();

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
