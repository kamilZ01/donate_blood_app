import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

class EmailSentDialog extends StatelessWidget {
  final _dialogTitle;
  final _dialogContent;

  EmailSentDialog(this._dialogTitle, this._dialogContent);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(_dialogTitle),
      content: new Text(_dialogContent),
      actions: <Widget>[
        new FlatButton(
          child: new Text(S.current.goToLogin),
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
              child: Text(S.current.ok),
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
