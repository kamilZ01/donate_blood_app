import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_emial_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import 'background.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _email = _email.trim();
      return true;
    }
    return false;
  }

  bool _validateAndSubmit() {
    if (_validateAndSave()) {
      Auth().sendPasswordResetMail(_email);
      return true;
    } else
      return false;
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
                  S.current.forgetPassword,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Image.asset(
                    "assets/icons/login.webp",
                    width: size.width * 0.5,
                  ),
                ),
                RoundedEmailField(
                  hintText: S.current.email,
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                RoundedButton(
                    text: S.current.forgetPassword,
                    press: () {
                      if (_validateAndSubmit()) {
                        _showPasswordResetEmailSentDialog();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPasswordResetEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(S.current.passwordResetEmailDialogTitle),
          content: new Text(S.current.passwordResetEmailDialogContent),
          actions: <Widget>[
            new FlatButton(
              child: new Text(S.current.dismiss),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
            new FlatButton(
              child: new Text(S.current.openEmailApp),
              onPressed: () async {
                var result = await OpenMailApp.openMailApp();
                // If no mail apps found, show error
                if (!result.didOpen && !result.canOpen) {
                  showNoMailAppsDialog(context);
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }
              },
            )
          ],
        );
      },
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.openEmailApp),
          content: Text(S.current.noMailApp),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            )
          ],
        );
      },
    );
  }
}
