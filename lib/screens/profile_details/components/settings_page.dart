import 'package:donate_blood/Screens/Welcome/welcome_screen.dart';
import 'package:donate_blood/constants.dart';
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
            Navigator.of(context).pop();
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
                  "Settings",
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
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            buildAccountOptionRow(context, "Change email", Icon(Icons.email), ChangeEmailPage()),
            buildAccountOptionRow(
                context, "Change password", Icon(Icons.vpn_key), ChangePasswordPage()),
            buildAccountOptionRow(
                context, "Language", Icon(Icons.language_outlined), ChangeEmailPage()),
            //buildAccountOptionRow(context, "Privacy and security", Icon(Icons.lock_outline_rounded)),
            //buildAccountOptionRow(context, "About", Icon(Icons.info)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Notifications",
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
            buildNotificationOptionRow("Urgent blood donation", true),
            buildNotificationOptionRow("Account activity", false),
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
                child: Text("SIGN OUT",
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

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, Icon icon, StatefulWidget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
        /*showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Option 1"),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );*/
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
}
