import 'package:donate_blood/Screens/home_user_page/components/user_detail.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
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
                UserDetail(controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
