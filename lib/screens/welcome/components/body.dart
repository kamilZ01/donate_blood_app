import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/Screens/Signup/signup_screen.dart';
import 'package:donate_blood/components/background.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //this size provide us total heigh and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: S.of(context).donate.toUpperCase() + "\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
                  TextSpan(
                    text: S.of(context).blood.toUpperCase() + "\n",
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 55,
                    ),
                  ),
                  TextSpan(
                    text: S.of(context).saveLives.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              child: Image.asset("assets/images/heart.png",
                  width: size.width * 0.8),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: S.of(context).login.toUpperCase(),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: S.of(context).signUp.toUpperCase(),
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
