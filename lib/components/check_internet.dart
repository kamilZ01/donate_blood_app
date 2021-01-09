import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';

class checkInternet {
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text(S.current.ok))
              ]);
        });
  }

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          InternetStatus = "Connected to the Internet";
          contentmessage = "Connected to the Internet";
          // _showDialog(InternetStatus, contentmessage, context);
          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = S.current.disconnected;
          contentmessage = S.current.checkStatus;
          _showDialog(InternetStatus, contentmessage, context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
