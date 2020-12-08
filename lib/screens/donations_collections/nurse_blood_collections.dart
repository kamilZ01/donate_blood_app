import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/Events/list_view_events.dart';
import 'package:donate_blood/components/no_blood_collections_message.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NurseBloodCollections extends StatefulWidget {
  @override
  _NurseBloodCollectionsState createState() => _NurseBloodCollectionsState();
}

class _NurseBloodCollectionsState extends State<NurseBloodCollections> {
  Query _nurseCollections;

  @override
  void initState() {
    super.initState();
    _nurseCollections = context.read<Repository>().getNurseCollections();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _nurseCollections.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(S.current.somethingWentWrong);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return new ListView(
                // controller: widget.controller,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                children: snapshot.data.size == 0
                    ? [
                        NoBloodCollectionsMessage(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Text(
                                        S.current.amount +
                                            ': ' +
                                            document
                                                .data()['amount']
                                                .toString() +
                                            ' ml',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      new Text(S.current.date +
                                          ": " +
                                          convertTimeStamp(
                                              document.data()['donationDate'])),
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: document
                                            .data()['userId']
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                user) {
                                          if (user.hasError) {
                                            return new Text(
                                                "Donor: no data available");
                                          }
                                          if (user.connectionState ==
                                              ConnectionState.active) {
                                            return Text("Donor: " +
                                                user.data.data()['fullName']);
                                          }
                                          return Text("Loading...");
                                        },
                                      ),
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
            },
          ),
        ],
      ),
    );
  }
}
