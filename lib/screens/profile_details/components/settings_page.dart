import 'package:donate_blood/Screens/Welcome/welcome_screen.dart';
import 'package:donate_blood/Screens/bottom_nav_screen.dart';
import 'package:donate_blood/Screens/profile_details/profile_details_screen.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/screens/profile_details/components/change_email_page.dart';
import 'package:donate_blood/screens/profile_details/components/change_password_page.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Route route =
                MaterialPageRoute(builder: (context) => BottomNavScreen(3));
            Navigator.pushReplacement(context, route).then(onGoBack);
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            buildNewWidget(context, S.current.changeEmail, Icon(Icons.email),
                ChangeEmailPage()),
            buildNewWidget(context, S.current.changePassword,
                Icon(Icons.vpn_key), ChangePasswordPage()),
            buildAccountOptionRow(context, S.current.changeLanguage,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            buildNotificationOptionRow(S.current.urgentBloodDonation, true),
            buildNotificationOptionRow(S.current.accountActivity, false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
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
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
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
            onChanged: (bool val) {},
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
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, Icon icona) {
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
                    onPressed: () {
                      setState(() {
                        S.load(Locale('pl', 'PL'));
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(S.current.polish),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        S.load(Locale('en', 'EN'));
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
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: icona,
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
    );
  }

  void refresh() {
    ProfilePage();
  }

  Future onGoBack(dynamic value) {
    refresh();
    setState(() {});
  }
}
