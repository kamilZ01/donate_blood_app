import 'package:donate_blood/Screens/HomeUserPage/components/user_information.dart';
import 'package:donate_blood/Screens/ProfileDetails/components/user_detail.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
            ),
            Column(
              children: [
                UserDetail(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Text(
                      "Recent donations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                UserInformation(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
