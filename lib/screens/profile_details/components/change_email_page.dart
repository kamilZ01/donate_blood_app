import 'package:donate_blood/components/email_sent_dialog.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_email_field.dart';
import 'package:donate_blood/components/rounded_password_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:donate_blood/components/background.dart';

import '../../../constants.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  String _newEmail;
  String _currentPassword;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _newEmail = _newEmail.trim();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
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
        body: Background(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.current.changeEmail.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icons/login.webp",
                      width: size.width * 0.5,
                    ),
                  ),
                  RoundedEmailField(
                    hintText: S.current.newMail,
                    onChanged: (value) {
                      _newEmail = value;
                    },
                  ),
                  RoundedPasswordField((value) {
                    _currentPassword = value;
                  }, S.current.currentPassword, false),
                  RoundedButton(
                      text: S.current.changeEmail.toUpperCase(),
                      press: () async {
                        if (_validateAndSave()) {
                          await Auth()
                              .changeEmail(_newEmail, _currentPassword)
                              .then((value) => {
                                    if (value == S.current.changedEmail)
                                      {
                                        showDialog<void>(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return EmailSentDialog(
                                                S.current
                                                    .verifyEmailDialogTitle,
                                                value + '\n' +S.current.verifyEmailDialogContent);
                                          },
                                        )
                                      }
                                    else if (value.isNotEmpty &&
                                        value.length > 0)
                                      {
                                        _scaffoldMessengerKey.currentState
                                            .showSnackBar(
                                                SnackBar(content: Text(value)))
                                      },
                                  });
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
