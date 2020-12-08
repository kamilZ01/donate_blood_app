import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NoBloodCollectionsMessage extends StatefulWidget {
  @override
  _NoBloodCollectionsMessageState createState() =>
      _NoBloodCollectionsMessageState();
}

class _NoBloodCollectionsMessageState extends State<NoBloodCollectionsMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: "There are no registered ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextSpan(
                  text: "blood",
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: " collections in your account. To add a",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: " blood",
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text:
                      " collection click the button in the bottom right-hand corner.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
