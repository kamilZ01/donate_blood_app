import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/components/already_have_an_account_check.dart';
import 'package:donate_blood/components/email_sent_dialog.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_email_field.dart';
import 'package:donate_blood/components/rounded_password_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/material.dart';

import 'package:donate_blood/components/background.dart';
import 'components/or_divider.dart';
import 'components/social_icons.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _confirmPassword;
  String _errorMessage = '';

  // Check if form is valid before perform signUp
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate() && _password == _confirmPassword) {
      _email = _email.trim();
      return true;
    } else if(form.validate()) {
      _errorMessage = S.current.differentPassword;
    }
    return false;
  }

  Future<bool> _validateAndSubmit() async {
    setState(() {
      _errorMessage = '';
    });
    if (_validateAndSave()) {
      String signUpResult;
      await Auth()
          .signUp(_email, _password)
          .then((value) => signUpResult = value);
      await Auth().sendEmailVerification();
      if (Auth().getCurrentUser() != null &&
          Auth().getCurrentUser().uid == signUpResult) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return EmailSentDialog(
                S.current.verifyEmailDialogTitle,
                S.current.verifyEmailDialogContent);
          },
        );
        return true;
      } else {
        _errorMessage = signUpResult;
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  S.current.signUp.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Image.asset(
                    "assets/icons/sign.webp",
                    height: size.height * 0.3,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                RoundedEmailField(
                  hintText: S.current.email,
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                RoundedPasswordField((value) {
                  _password = value;
                }, S.current.password, true),
                RoundedPasswordField((value) {
                  _confirmPassword = value;
                }, S.current.confirmPassword, true),
                RoundedButton(
                  text: S.current.signUp.toUpperCase(),
                  press: () {
                    _validateAndSubmit().then((value) => {
                          if (!value)
                            {
                              if (_errorMessage.length > 0)
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_errorMessageWidget()),
                            }
                        });
                  },
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
        ),
      ),
    );
  }

  Widget _errorMessageWidget() {
    return SnackBar(
      content: Text(
        _errorMessage,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
