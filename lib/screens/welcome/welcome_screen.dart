import 'package:donate_blood/Screens/Welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Body(),
        ),
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        });
  }
}
