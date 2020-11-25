import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/services/user_data.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      height: 130,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 8.0,
          ),
        ],
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                "Welcome, Jan i",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "AB+",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Blood group",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      height: 45,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: UserData().getUserDonors().snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return Text(
                              snapshot.hasData ? snapshot.data.size.toString() + 'x': '-',
                              style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                   /*   Text(
                        UserData().getNumUserDonors(),
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,)
                      ),*/
                      Text(
                        "Donor",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
