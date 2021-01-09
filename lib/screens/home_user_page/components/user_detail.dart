import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/donations_collections/nurse_blood_collections.dart';
import 'package:donate_blood/Screens/donations_collections/user_donations.dart';
import 'package:donate_blood/Screens/home_user_page/components/badges_list.dart';
import 'package:donate_blood/components/donation_type_translation.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:flutter/cupertino.dart';
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
  final translation = DonationType();
  Stream<DocumentSnapshot> _userData;
  Stream<QuerySnapshot> _userDonations;
  Stream<QuerySnapshot> _nurseCollections;
  int totalAmountOfBloodDonated,
      totalAmountOfDonatedBloodInCurrentYear,
      totalAmountOfDonatedBloodInLastYear,
      totalCollected,
      totalCollectedInCurrentMonth,
      totalCollectedInCurrentDay,
      totalCollectedInCurrentYear,
      totalCollectedInLastYear;
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
    totalAmountOfDonatedBloodInCurrentYear = 0;
    totalAmountOfDonatedBloodInLastYear = 0;
    totalCollected = 0;
    totalCollectedInCurrentMonth = 0;
    totalCollectedInCurrentDay = 0;
    totalCollectedInCurrentYear = 0;
    totalCollectedInLastYear = 0;
    typeOfLastDonation = "N/A";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: _userData,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text(S.current.somethingWentWrong);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(S.current.loading);
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return StreamBuilder<QuerySnapshot>(
                stream: snapshot.data.data()['isNurse']
                    ? _nurseCollections
                    : _userDonations,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return new Text("-");
                  }
                  if (querySnapshot.connectionState == ConnectionState.active) {
                    if (querySnapshot.hasData && querySnapshot.data.size > 0) {
                      totalAmountOfBloodDonated = 0;
                      totalAmountOfDonatedBloodInCurrentYear = 0;
                      totalAmountOfDonatedBloodInLastYear = 0;
                      totalCollected = 0;
                      totalCollectedInCurrentMonth = 0;
                      totalCollectedInCurrentDay = 0;
                      totalCollectedInCurrentYear = 0;
                      totalCollectedInLastYear = 0;

                      if (!snapshot.data.data()['isNurse']) {
                        lastDonation =
                            querySnapshot.data.docs.first['donationDate'];
                        typeOfLastDonation =
                            querySnapshot.data.docs.first['donationType'];
                        querySnapshot.data.docs.forEach((element) {
                          totalAmountOfBloodDonated += element.data()['amount'];
                          if (getYearFromDonationDate(
                                  element.data()['donationDate'], "year") ==
                              DateTime.now().year) {
                            totalAmountOfDonatedBloodInCurrentYear +=
                                element.data()['amount'];
                          }
                          if (getYearFromDonationDate(
                                  element.data()['donationDate'], "year") ==
                              DateTime.now().year - 1) {
                            totalAmountOfDonatedBloodInLastYear +=
                                element.data()['amount'];
                          }
                        });
                      } else {
                        querySnapshot.data.docs.forEach((element) {
                          totalCollected += element.data()['amount'];
                          if (getYearFromDonationDate(
                                      element.data()['donationDate'],
                                      "month") ==
                                  DateTime.now().month &&
                              getYearFromDonationDate(
                                      element.data()['donationDate'], "year") ==
                                  DateTime.now().year) {
                            totalCollectedInCurrentMonth +=
                                element.data()['amount'];
                          }
                          if (calculateDifferenceBetweenDates(
                                  element.data()['donationDate']) ==
                              0) {
                            totalCollectedInCurrentDay +=
                                element.data()['amount'];
                          }
                          if (getYearFromDonationDate(
                                  element.data()['donationDate'], "year") ==
                              DateTime.now().year) {
                            totalCollectedInCurrentYear +=
                                element.data()['amount'];
                          }
                          if (getYearFromDonationDate(
                                  element.data()['donationDate'], "year") ==
                              DateTime.now().year - 1) {
                            totalCollectedInLastYear +=
                                element.data()['amount'];
                          }
                        });
                      }

                      return Column(
                        children: [
                          buildWelcomeHeader(context, snapshot, querySnapshot),
                          if (snapshot.data.data()['isNurse'])
                            Container(
                              child: Column(
                                children: [
                                  NurseBloodCollections(
                                      true, widget.scrollController),
                                  headerTitle(
                                      S.current.informationAboutCollections),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                        bottom: 5,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 20.0),
                                            child: Column(
                                              children: [
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.inLastYear,
                                                    totalCollectedInLastYear
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.inCurrentYear,
                                                    totalCollectedInCurrentYear
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.inCurrentMonth,
                                                    totalCollectedInCurrentMonth
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.today,
                                                    totalCollectedInCurrentDay
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.collectedInTotal,
                                                    totalCollected.toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                // buildRowWithInformation(
                                                //     context,
                                                //     "Oddano w poprzednim roku",
                                                //     totalAmountOfDonatedBloodInLastYear
                                                //         .toString(),
                                                //     true,
                                                //     " ml",
                                                //     " ml"),
                                                // buildRowWithInformation(
                                                //     context,
                                                //     "Oddano w obecnym roku",
                                                //     totalAmountOfDonatedBloodInCurrentYear
                                                //         .toString(),
                                                //     true,
                                                //     " ml",
                                                //     " ml"),
                                                // buildRowWithInformation(
                                                //     context,
                                                //     S.current.totalDonated,
                                                //     totalAmountOfBloodDonated
                                                //         .toString(),
                                                //     true,
                                                //     " ml",
                                                //     " ml"),
                                                // buildRowWithInformation(
                                                //     context,
                                                //     S.current.nextBadgeFor,
                                                //     (2000 - totalAmountOfBloodDonated)
                                                //         .toString(),
                                                //     true,
                                                //     " ml",
                                                //     " ml"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(
                              child: Column(
                                children: [
                                  UserDonations(true, widget.scrollController),
                                  headerTitle(S.current.information),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                        bottom: 5,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 20.0),
                                            child: Column(
                                              children: [
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.lastDonation,
                                                    convertTimeStamp(
                                                        lastDonation),
                                                    false,
                                                    "",
                                                    ""),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.typeOfDonation,
                                                    translation
                                                        .getTranslationOfBlood(
                                                            typeOfLastDonation),
                                                    false,
                                                    "",
                                                    ""),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.inLastYear,
                                                    totalAmountOfDonatedBloodInLastYear
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.inCurrentYear,
                                                    totalAmountOfDonatedBloodInCurrentYear
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.totalDonated,
                                                    totalAmountOfBloodDonated
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.nextBadgeFor,
                                                    (2000 - totalAmountOfBloodDonated)
                                                        .toString(),
                                                    true,
                                                    " ml",
                                                    " ml"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  headerTitle(S.current.nextDonation),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                        bottom: 5,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 20.0),
                                            child: Column(
                                              children: [
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.wholeBlood,
                                                    newFormat.format(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "whole blood")),
                                                    true,
                                                    S.current.days,
                                                    dateDifference(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "whole blood"))),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.plasma,
                                                    newFormat.format(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "plasma")),
                                                    true,
                                                    S.current.days,
                                                    dateDifference(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "plasma"))),
                                                buildRowWithInformation(
                                                    context,
                                                    S.current.platelets,
                                                    newFormat.format(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "platelets")),
                                                    true,
                                                    S.current.days,
                                                    dateDifference(
                                                        calcNextDonation(
                                                            lastDonation,
                                                            typeOfLastDonation,
                                                            "platelets"))),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  headerTitle(S.current.yourBadges),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BadgesList(totalAmountOfBloodDonated,
                                      snapshot.data.data()['gender'])
                                ],
                              ),
                            ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        buildWelcomeHeader(context, snapshot, querySnapshot),
                        snapshot.data.data()['isNurse']
                            ? NurseBloodCollections(
                                true, widget.scrollController)
                            : UserDonations(true, widget.scrollController)
                      ],
                    );
                  }
                  return Text(S.current.somethingWentWrong);
                },
              );
            }
          }
          return Text(S.current.loading);
        },
      ),
    );
  }

  Padding buildRowWithInformation(
      BuildContext context,
      String subtitle,
      String dataToSubtitle,
      bool moreInformation,
      String typeOfAdditionalInformation,
      String additionalInformation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
                    text: subtitle,
                    style: TextStyle(fontSize: 16, color: Colors.black))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                      text: dataToSubtitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: kPrimaryColor)),
                  if (moreInformation)
                    if (typeOfAdditionalInformation
                        .toLowerCase()
                        .contains('ml'))
                      TextSpan(
                          text: additionalInformation,
                          style: TextStyle(fontSize: 16))
                    else if (typeOfAdditionalInformation
                        .toLowerCase()
                        .contains(S.current.days))
                      TextSpan(
                          text: " (" +
                              additionalInformation +
                              " " +
                              typeOfAdditionalInformation +
                              ")",
                          style: TextStyle(
                            fontSize: 16,
                          ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerTitle(String title) {
    return Container(
      padding: EdgeInsets.only(left: 25, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Column buildWelcomeHeader(
      BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot,
      AsyncSnapshot<QuerySnapshot> querySnapshot) {
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
                            S.current.bloodGroup,
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
                          Text(
                            querySnapshot.hasData
                                ? querySnapshot.data.size.toString() + 'x'
                                : '-',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
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
      ],
    );
  }
}

String splitValue(String fullName) {
  return fullName.split(" ")[0];
}

int calculateDifferenceBetweenDates(Timestamp timestamp) {
  DateTime now = DateTime.now();
  DateTime dateFromDataBase = timestamp.toDate();

  return DateTime(
          dateFromDataBase.year, dateFromDataBase.month, dateFromDataBase.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
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

int getYearFromDonationDate(Timestamp timestamp, String type) {
  if (timestamp != null) {
    switch (type) {
      case "year":
        {
          return timestamp.toDate().year;
        }
        break;
      case "month":
        {
          return timestamp.toDate().month;
        }
        break;
      case "day":
        {
          return timestamp.toDate().day;
        }
        break;
      default:
        {
          return 0;
        }
    }
  } else
    return 0;
}

DateTime calcNextDonation(
    Timestamp timestamp, String lastDonationType, String nextDonationType) {
  DateTime lastDonationDate;
  DateTime newDonationDate;
  String wholeBlood = S.current.wholeBlood;

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
  final difference = nextDonation.difference(DateTime.now()).inDays;
  return difference.toString();
}

class Test {
  static String mess() {
    return "Test";
  }
}
