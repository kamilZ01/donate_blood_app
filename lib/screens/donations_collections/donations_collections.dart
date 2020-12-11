import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/donations_collections//user_donations.dart';
import 'package:donate_blood/Screens/donations_collections//nurse_blood_collections.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationsCollections extends StatefulWidget {
  @override
  _DonationsCollectionsState createState() => _DonationsCollectionsState();
}

class _DonationsCollectionsState extends State<DonationsCollections> {
  Stream<DocumentSnapshot> _userData;
  bool isNurse;

  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
  }

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: _userData,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.exists) {
              return Scaffold(
                body: Column(
                  children: [
                    CustomPaint(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      painter: HeaderCurvedContainer(),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(
                        top: 65,
                        bottom: 55,
                      ),
                      child: Text(
                        snapshot.data.data()['isNurse']
                            ? S.current.bloodCollections
                            : S.current.donations,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    snapshot.data.data()['isNurse']
                        ? Expanded(
                            child:
                                NurseBloodCollections(false, scrollController))
                        : Expanded(
                            child: UserDonations(false, scrollController)),
                  ],
                ),
                floatingActionButton: snapshot.data.data()['isNurse']
                    ? FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () /*async*/ {
                          // await showInformationDialog(context);
                          // dateTime = null;
                          // timeOfDay = null;
                        },
                        backgroundColor: Colors.red,
                      )
                    : Container(),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text(S.current.somethingWentWrong);
          }
          return Container();
        },
      ),
    );
  }
}
