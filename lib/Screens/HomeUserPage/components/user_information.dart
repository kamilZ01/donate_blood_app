import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class UserInformation extends StatelessWidget {
  final ScrollController controller;

  UserInformation(this.controller);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: UserData()
          .getUserDonors()
          .orderBy('donationDate', descending: false)
          .limitToLast(2)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(S.current.somethingWentWrong);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return new ListView(
          controller: controller,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          children: snapshot.data.size == 0
              ? [
                  Container(
                    // margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    // padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: "You haven't donated ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                  )
                ]
              : snapshot.data.docs.map(
                  (DocumentSnapshot document) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 0,
                      ),
                      child: Column(
                        children: [
                          new ListTile(
                            leading: CircleAvatar(
                              child: SvgPicture.asset(
                                  'assets/icons/blood-donation.svg'),
                              backgroundColor: Colors.white,
                            ),
                            title: new Text(
                              document.data()['donationType'],
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
                                  S.current.amount +
                                      ': ' +
                                      document.data()['amount'].toString() +
                                      ' ml',
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                new Text(S.current.date +
                                    ": " +
                                    convertTimeStamp(
                                        document.data()['donationDate'])),
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
                  },
                ).toList(),
        );
        return Container();
      },
    );
  }
}

String convertTimeStamp(Timestamp timestamp) {
  DateTime myDateTime = timestamp.toDate();
  var newFormat = DateFormat("dd/MM/yyyy");
  String updatedDt = newFormat.format(myDateTime);
  return updatedDt;
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
