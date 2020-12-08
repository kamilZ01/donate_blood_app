import 'package:flutter/material.dart';

class NoDonationMessage extends StatefulWidget {
  @override
  _NoDonationMessageState createState() => _NoDonationMessageState();
}

class _NoDonationMessageState extends State<NoDonationMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: "You haven't donated ",
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
                  text: " yet. \n 1",
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
                  text: " donation can save up to 3 ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: "lives.",
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n For someone, your ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                  text: " is the best gift ever.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                // TextSpan(
                //   text: S.of(context).saveLives.toUpperCase(),
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold, fontSize: 31),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
