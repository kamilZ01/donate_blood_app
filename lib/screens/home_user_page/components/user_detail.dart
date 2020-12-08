import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/donations_collections/nurse_blood_collections.dart';
import 'package:donate_blood/Screens/donations_collections/user_donations.dart';
import 'package:donate_blood/Screens/home_user_page/components/badges_list.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatefulWidget {
  final ScrollController scrollController;

  UserDetail(this.scrollController);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  Stream<DocumentSnapshot> _userData;
  Stream<QuerySnapshot> _userDonors;
  Stream<QuerySnapshot> _nurseCollections;

  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
    _userDonors = context.read<Repository>().getUserDonations().snapshots();
    _nurseCollections =
        context.read<Repository>().getNurseCollections().snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _userData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text(S.current.somethingWentWrong);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(S.current.loading);
        }
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
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
                        snapshot.hasData
                            ? S.current.welcome +
                                ', ' +
                                splitValue(snapshot.data.data()['fullName'])
                            : '-',
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
                                snapshot.hasData &&
                                        snapshot.data
                                            .data()['bloodGroup']
                                            .toString()
                                            .isNotEmpty
                                    ? snapshot.data.data()['bloodGroup']
                                    : 'N/A',
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
                                stream: snapshot.data.data()['isNurse']
                                    ? _nurseCollections
                                    : _userDonors,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return new Text("-");
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    return Text(
                                      snapshot.hasData
                                          ? snapshot.data.size.toString() + 'x'
                                          : '-',
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  return Text(S.current.loading);
                                },
                              ),
                              Text(
                                snapshot.data.data()['isNurse']
                                    ? S.current.collections
                                    : S.current.donor,
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
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(
                  left: 25,
                ),
                child: Text(
                  snapshot.data.data()['isNurse']
                      ? S.current.recentCollections
                      : S.current.recentDonations,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            snapshot.data.data()['isNurse']
                ? NurseBloodCollections(true, widget.scrollController)
                : Column(
                    children: [
                      UserDonations(true, widget.scrollController),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 25,
                          ),
                          child: Text(
                            S.current.yourBadges,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BadgesList()
                    ],
                  ),
          ],
        );
      },
    );
  }
}

String splitValue(String fullName) {
  return fullName.split(" ")[0];
}

String convertTimeStamp(Timestamp timestamp) {
  DateTime myDateTime = timestamp.toDate();
  var newFormat = DateFormat("dd/MM/yyyy");
  String updatedDt = newFormat.format(myDateTime);
  return updatedDt;
}
