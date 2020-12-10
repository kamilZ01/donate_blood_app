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
  Stream<QuerySnapshot> _userDonations;
  Stream<QuerySnapshot> _nurseCollections;
  int totalAmountOfBloodDonated;
  Timestamp lastDonation;
  String typeOfLastDonation;
  var newFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
    _userDonations = context
        .read<Repository>()
        .getUserDonations()
        .orderBy('donationDate', descending: true)
        .snapshots();
    _nurseCollections =
        context.read<Repository>().getNurseCollections().snapshots();
    totalAmountOfBloodDonated = 0;
    // lastDonation = '2020-01-01 10:10:10+05:30';
    typeOfLastDonation = "N/A";
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
                                    : _userDonations,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return new Text("-");
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      totalAmountOfBloodDonated = 0;
                                      lastDonation = snapshot
                                          .data.docs.first['donationDate'];
                                      typeOfLastDonation = snapshot
                                          .data.docs.first['donationType'];
                                      snapshot.data.docs.forEach((element) {
                                        totalAmountOfBloodDonated +=
                                            element.data()['amount'];
                                      });
                                    }
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
                : Container(
                    child: Column(
                      children: [
                        UserDonations(true, widget.scrollController),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 5,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 20.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                          text: "Last donation",
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ]),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                        text: convertTimeStamp(
                                                            lastDonation),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                          text: "Type donation",
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ]),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            typeOfLastDonation,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                          text: "Total donated",
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ]),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: RichText(
                                                text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            totalAmountOfBloodDonated
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                      TextSpan(
                                                          text: " ml",
                                                          style: TextStyle(
                                                              fontSize: 16))
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    TextSpan(
                                                        text: "Next badge for",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ]),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: RichText(
                                              text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          (totalAmountOfBloodDonated)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: kPrimaryColor),
                                                    ),
                                                    TextSpan(
                                                        text: " ml",
                                                        style: TextStyle(
                                                            fontSize: 16))
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(left: 25, bottom: 5),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "Next donation",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     padding: EdgeInsets.all(4.0),
                        //     margin: EdgeInsets.only(
                        //       left: 20,
                        //       right: 20,
                        //       top: 0,
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 15.0, right: 20.0),
                        //           child: Column(
                        //             children: [
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(bottom: 2.0),
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Align(
                        //                       alignment: Alignment.centerLeft,
                        //                       child: RichText(
                        //                         text: TextSpan(
                        //                             style: DefaultTextStyle.of(
                        //                                     context)
                        //                                 .style,
                        //                             children: [
                        //                               TextSpan(
                        //                                   text: "Whole blood",
                        //                                   style: TextStyle(
                        //                                       fontSize: 16)),
                        //                             ]),
                        //                       ),
                        //                     ),
                        //                     Align(
                        //                       alignment: Alignment.centerRight,
                        //                       child: RichText(
                        //                         text: TextSpan(
                        //                             style: DefaultTextStyle.of(
                        //                                     context)
                        //                                 .style,
                        //                             children: [
                        //                               TextSpan(
                        //                                 text: newFormat.format(
                        //                                     calcNextDonation(
                        //                                         lastDonation,
                        //                                         typeOfLastDonation,
                        //                                         "whole blood")),
                        //                                 style: TextStyle(
                        //                                     fontWeight:
                        //                                         FontWeight.bold,
                        //                                     fontSize: 16,
                        //                                     color: kPrimaryColor),
                        //                               ),
                        //                               TextSpan(
                        //                                 text: " (" +
                        //                                     dateDifference(
                        //                                         calcNextDonation(
                        //                                             lastDonation,
                        //                                             typeOfLastDonation,
                        //                                             "whole blood")) +
                        //                                     " days)",
                        //                                 style: TextStyle(
                        //                                   fontSize: 16,
                        //                                 ),
                        //                               ),
                        //                             ]),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(bottom: 2.0),
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Align(
                        //                       alignment: Alignment.centerLeft,
                        //                       child: RichText(
                        //                         text: TextSpan(
                        //                             style: DefaultTextStyle.of(
                        //                                     context)
                        //                                 .style,
                        //                             children: [
                        //                               TextSpan(
                        //                                   text: "Plasma",
                        //                                   style: TextStyle(
                        //                                       fontSize: 16)),
                        //                             ]),
                        //                       ),
                        //                     ),
                        //                     Align(
                        //                       alignment: Alignment.centerRight,
                        //                       child: RichText(
                        //                         text: TextSpan(
                        //                             style: DefaultTextStyle.of(
                        //                                     context)
                        //                                 .style,
                        //                             children: [
                        //                               TextSpan(
                        //                                 text: newFormat.format(
                        //                                     calcNextDonation(
                        //                                         lastDonation,
                        //                                         typeOfLastDonation,
                        //                                         "plasma")),
                        //                                 style: TextStyle(
                        //                                     fontWeight:
                        //                                         FontWeight.bold,
                        //                                     fontSize: 16,
                        //                                     color: kPrimaryColor),
                        //                               ),
                        //                               TextSpan(
                        //                                 text: " (" +
                        //                                     dateDifference(
                        //                                         calcNextDonation(
                        //                                             lastDonation,
                        //                                             typeOfLastDonation,
                        //                                             "plasma")) +
                        //                                     " days)",
                        //                                 style: TextStyle(
                        //                                   fontSize: 16,
                        //                                 ),
                        //                               ),
                        //                             ]),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Align(
                        //                     alignment: Alignment.centerLeft,
                        //                     child: RichText(
                        //                       text: TextSpan(
                        //                           style:
                        //                               DefaultTextStyle.of(context)
                        //                                   .style,
                        //                           children: [
                        //                             TextSpan(
                        //                                 text: "Platelets",
                        //                                 style: TextStyle(
                        //                                     fontSize: 16)),
                        //                           ]),
                        //                     ),
                        //                   ),
                        //                   Align(
                        //                     alignment: Alignment.centerRight,
                        //                     child: RichText(
                        //                       text: TextSpan(
                        //                           style:
                        //                               DefaultTextStyle.of(context)
                        //                                   .style,
                        //                           children: [
                        //                             TextSpan(
                        //                               text: newFormat.format(
                        //                                   calcNextDonation(
                        //                                       lastDonation,
                        //                                       typeOfLastDonation,
                        //                                       "platelets")),
                        //                               style: TextStyle(
                        //                                   fontWeight:
                        //                                       FontWeight.bold,
                        //                                   fontSize: 16,
                        //                                   color: kPrimaryColor),
                        //                             ),
                        //                             TextSpan(
                        //                               text: " (" +
                        //                                   dateDifference(
                        //                                       calcNextDonation(
                        //                                           lastDonation,
                        //                                           typeOfLastDonation,
                        //                                           "platelets")) +
                        //                                   " days)",
                        //                               style: TextStyle(
                        //                                 fontSize: 16,
                        //                               ),
                        //                             ),
                        //                           ]),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
  DateTime myDateTime;
  if (timestamp != null) {
    myDateTime = timestamp.toDate();
    var newFormat = DateFormat("dd/MM/yyyy");
    String updatedDt = newFormat.format(myDateTime);
    return updatedDt;
  } else
    return "N/A";
}

DateTime calcNextDonation(
    Timestamp timestamp, String lastDonationType, String nextDonationType) {
  DateTime lastDonationDate;
  DateTime newDonationDate;

  if (timestamp != null) {
    lastDonationDate = timestamp.toDate();
    switch (lastDonationType.toLowerCase()) {
      case "whole blood":
        switch (nextDonationType.toLowerCase()) {
          case "whole blood":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 57));
            }
            break;
          case "plasma":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 30));
            }
            break;
          case "platelets":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 57));
            }
            break;
          default:
            {
              //TODO: return null and check the value in TextSpan
              // newDateTime = "N/A";
            }
            break;
        }
        break;
      case "plasma":
        switch (nextDonationType.toLowerCase()) {
          case "whole blood":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 30));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          case "plasma":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 14));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          case "platelets":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 30));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          default:
            {
              //TODO: return null and check the value in TextSpan
              // newDateTime = "N/A";
            }
            break;
        }
        break;
      case "platelets":
        switch (nextDonationType.toLowerCase()) {
          case "whole blood":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 28));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          case "plasma":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 28));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          case "platelets":
            {
              newDonationDate = lastDonationDate.add(new Duration(days: 28));
              // newDateTime = newFormat.format(newDonationDate);
            }
            break;
          default:
            {
              //TODO: return null and check the value in TextSpan
              // newDateTime = "N/A";
            }
            break;
        }
        break;
      default:
        {
          //TODO: return null and check the value in TextSpan
          // newDateTime = "N/A";
        }
        break;
    }
  }
  return newDonationDate;
}

String dateDifference(DateTime nextDonation) {
  // final date2 = DateTime.now();
  final difference = nextDonation.difference(DateTime.now()).inDays;

  return difference.toString();
}
