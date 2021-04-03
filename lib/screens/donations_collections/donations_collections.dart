import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:donate_blood/Screens/donations_collections//user_donations.dart';
import 'package:donate_blood/Screens/donations_collections//nurse_blood_collections.dart';
import 'package:donate_blood/components/build_text_form.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:donate_blood/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonationsCollections extends StatefulWidget {
  @override
  _DonationsCollectionsState createState() => _DonationsCollectionsState();
}

class _DonationsCollectionsState extends State<DonationsCollections> {
  Stream<DocumentSnapshot> _userData;
  Query _users;
  bool isNurse;
  String _donor;
  String _nurse;
  int _amount;
  String _donationType;
  DateTime _donationDate;

  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
    _users = context.read<Repository>().getUsers();
    _nurse = Auth().getCurrentUser().uid;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _users.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  List _donors = snapshot.data.docs
                                      .map((element) => {
                                            "display":
                                                element.data()['fullName'],
                                            "value": element.id
                                          })
                                      .toList();
                                  _donors.removeWhere(
                                      (value) => value["value"] == _nurse);
                                  return DropDownFormField(
                                    contentPadding: EdgeInsets.only(right: 10),
                                    filled: false,
                                    validator: (value) {
                                      if (value == null) {
                                        return S
                                            .current.donorSelectionIsRequired;
                                      }
                                      return null;
                                    },
                                    titleText: S.current.donor,
                                    hintText: S.current.pleaseChooseOne,
                                    value: _donor,
                                    onChanged: (value) {
                                      setState(() {
                                        _donor = value;
                                      });
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _donor = value;
                                      });
                                    },
                                    dataSource: _donors,
                                    textField: "display",
                                    valueField: "value",
                                  );
                                }
                                return CircularProgressIndicator();
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: DropDownFormField(
                              contentPadding: EdgeInsets.only(right: 10),
                              filled: false,
                              validator: (value) {
                                if (value == null) {
                                  return S
                                      .current.donationTypeSelectionIsRequired;
                                }
                                return null;
                              },
                              titleText: S.current.donationType,
                              hintText: S.current.pleaseChooseOne,
                              value: _donationType,
                              onChanged: (value) {
                                setState(() {
                                  _donationType = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _donationType = value;
                                });
                              },
                              dataSource:
                                  context.watch<Repository>().getDonationType(),
                              textField: "display",
                              valueField: "value",
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: BuildTextForm(
                              S.current.amount,
                              _amount.toString(),
                              TextInputType.number, (value) {
                            _amount = int.parse(value);
                          }, (value) {
                            _amount = int.parse(value.trim());
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: DateTimeFormField(
                              dateTextStyle: TextStyle(
                                fontSize: 15,
                              ),
                              onDateSelected: (DateTime date) {
                                setState(() {
                                  _donationDate = date;
                                });
                              },
                              onSaved: (DateTime date) {
                                setState(() {
                                  _donationDate = date;
                                });
                              },
                              lastDate: DateTime.now(),
                              initialValue: DateTime.now(),
                              dateFormat: DateFormat("d MMMM y, H:mm"),
                              mode: DateTimeFieldPickerMode.dateAndTime,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 15, top: 10),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.shade700),
                                ),
                                labelText: S.current.donationDate,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: S.current.pleaseEnterValue(
                                    S.current.donationDate.toLowerCase()),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  height: 2.3,
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              context.read<Repository>().addDonation(
                                  _donor,
                                  _nurse,
                                  _donationType,
                                  _amount,
                                  _donationDate);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: Text(S.current.addDonation,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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
                                NurseBloodCollections(false, _scrollController))
                        : Expanded(
                            child: UserDonations(false, _scrollController)),
                  ],
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text(S.current.somethingWentWrong);
          }
          return Container();
        },
      ),
      floatingActionButton: StreamBuilder<DocumentSnapshot>(
        stream: _userData,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.exists && snapshot.data.data()['isNurse'])
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await showInformationDialog(context);
                },
                backgroundColor: Colors.red,
              );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text(S.current.somethingWentWrong);
          }
          return Container();
        },
      ),
    );
  }
}
