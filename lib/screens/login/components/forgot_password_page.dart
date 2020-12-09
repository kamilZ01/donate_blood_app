import 'package:donate_blood/components/email_sent_dialog.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_email_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:donate_blood/components/background.dart';

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
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return EmailSentDialog(
                                S.current.passwordResetEmailDialogTitle,
                                S.current.passwordResetEmailDialogContent);
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
