/*
import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/Screens/Signup/components/background.dart';
import 'package:donate_blood/Screens/Signup/components/or_divider.dart';
import 'package:donate_blood/Screens/Signup/components/social_icons.dart';
import 'package:donate_blood/components/already_have_an_account_check.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_input_field.dart';
import 'package:donate_blood/components/rounded_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Image.asset(
                "assets/icons/sign.png",
                height: size.height * 0.3,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.png",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.png",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.png",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
