import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_formatter/time_formatter.dart';

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query users = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('created', descending: true);
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return new ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  new ListTile(
                    leading: CircleAvatar(
                      child:
                          SvgPicture.asset('assets/icons/blood-donation.svg'),
                      backgroundColor: Colors.white,
                    ),
                    title: new Text(
                      document.data()['owner'],
                      style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    subtitle: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          'Amount: ' + document.data()['title'] + ' ml',
                          style: new TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        new Text("Date: "),
                        Divider(
                          thickness: 3,
                        ),
                        // new Text(formatTime(document.data()['created'])),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

String convertTimeStamp(timeStamp) {
  String formatted = formatTime(timeStamp).toString();
  return formatted;
}
