import 'package:donate_blood/Screens/Welcome/welcome_screen.dart';
import 'package:donate_blood/Screens/bottom_nav_screen.dart';
import 'package:donate_blood/Screens/profile_details/profile_details_screen.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/screens/profile_details/components/change_email_page.dart';
import 'package:donate_blood/screens/profile_details/components/change_password_page.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  bool isEventNotifications = true;
  bool isAccountActivityNotifications = true;
  String currentLanguage;

  @override
  Widget build(BuildContext context) {
    _preferences.then((value) {
      setState(() {
        if (value.getString("delegate") != null)
          currentLanguage = value.getString("delegate").toUpperCase();
        else
          currentLanguage = Localizations.localeOf(context).languageCode.toUpperCase();
        if (value.getBool("eventNotifications") != null)
          isEventNotifications = value.getBool("eventNotifications");
        else
          value.setBool("eventNotifications", true);
        if (value.getBool("accountActivityNotifications") != null)
          isAccountActivityNotifications =
              value.getBool("accountActivityNotifications");
        else
          value.setBool("accountActivityNotifications", true);
      });
    });
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavScreen(3)))
                    .then(onGoBack);
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: kPrimaryColor,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.current.settings,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      S.current.account,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                buildNewWidget(context, S.current.changeEmail,
                    Icon(Icons.email), ChangeEmailPage()),
                buildNewWidget(context, S.current.changePassword,
                    Icon(Icons.vpn_key), ChangePasswordPage()),
                buildLanguageOptionRow(context, S.current.changeLanguage,
                    Icon(Icons.language_outlined)),
                //buildAccountOptionRow(context, "Privacy and security", Icon(Icons.lock_outline_rounded)),
                //buildAccountOptionRow(context, "About", Icon(Icons.info)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.current.notifications,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildNotificationOptionRow(
                    S.current.eventNotifications, isEventNotifications,
                    (bool value) async {
                  setState(() {
                    isEventNotifications = value;
                    _preferences.then((value) => value.setBool(
                        "eventNotifications", isEventNotifications));
                  });
                  if (isEventNotifications)
                    await FirebaseMessaging.instance
                        .subscribeToTopic( 'event' + currentLanguage);
                  else
                    await FirebaseMessaging.instance
                        .unsubscribeFromTopic( 'event' + currentLanguage);
                  //print('Zmiana eventu:' + currentLanguage);
                }),
                buildNotificationOptionRow(
                    S.current.accountActivity, isAccountActivityNotifications,
                    (bool value) {
                  setState(() {
                    isAccountActivityNotifications = value;
                    _preferences.then((value) => value.setBool(
                        "accountActivityNotifications",
                        isAccountActivityNotifications));
                  });
                }),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      String fcmToken =
                          await FirebaseMessaging.instance.getToken();
                      if (fcmToken != null) {
                        context
                            .read<Repository>()
                            .removeFcmTokenFromUser(fcmToken);
                      }
                      Auth().signOut().then((value) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()))
                          });
                    },
                    color: Colors.red,
                    child: Text(S.current.signOutUpperCase,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavScreen(3)))
              .then(onGoBack);
          return true;
        });
  }

  Row buildNotificationOptionRow(
      String title, bool isActive, ValueChanged<bool> changed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            trackColor: kPrimaryColor,
            value: isActive,
            onChanged: changed,
          ),
        ),
      ],
    );
  }

  GestureDetector buildNewWidget(
      BuildContext context, String title, Icon icon, StatefulWidget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.1),
        child: Card(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: icon,
                onPressed: () {},
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[450],
                ),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildLanguageOptionRow(
      BuildContext context, String title, Icon icon) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(
                    onPressed: () async {
                      await FirebaseMessaging.instance.unsubscribeFromTopic('event' + currentLanguage);
                      await FirebaseMessaging.instance.subscribeToTopic('eventPL');
                      setState(() {
                        S.load(Locale('pl', 'PL'));
                        _preferences
                            .then((value) => value.setString("delegate", 'pl'));
                        currentLanguage = 'PL';
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(S.current.polish),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await FirebaseMessaging.instance.unsubscribeFromTopic('event' + currentLanguage);
                      await FirebaseMessaging.instance.subscribeToTopic('eventEN');
                      setState(() {
                        S.load(Locale('en', 'EN'));
                        _preferences
                            .then((value) => value.setString("delegate", "en"));
                        currentLanguage = 'EN';
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(S.current.english),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.1),
        child: Card(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: icon,
                onPressed: () {},
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[450],
                ),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    ProfilePage();
  }

  void onGoBack(dynamic value) {
    refresh();
    setState(() {});
  }
}
