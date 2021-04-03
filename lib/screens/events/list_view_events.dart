import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:donate_blood/components/build_text_form.dart';
import 'package:donate_blood/components/donation_type_translation.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListViewEvents extends StatefulWidget {
  @override
  _ListViewEventsState createState() => _ListViewEventsState();
}

class _ListViewEventsState extends State<ListViewEvents> {
  final translation = DonationType();
  Stream<DocumentSnapshot> _userData;
  String eventType;
  String location;
  String donationType;
  DateTime eventDate;
  String message;
  List donationTypeList;
  List eventTypeList;

  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
    message = '';
    donationTypeList = context.read<Repository>().getDonationType();
    eventTypeList = context.read<Repository>().getEventType();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //add more form field
  Future<void> showAddEventForm(BuildContext context) async {
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
                              value: donationType,
                              onChanged: (value) {
                                setState(() {
                                  donationType = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  donationType = value;
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
                              S.current.place, location, TextInputType.text,
                              (value) {
                            location = value;
                          }, (value) {
                            location = value.trim();
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
                              titleText: S.current.eventType,
                              hintText: S.current.pleaseChooseOne,
                              value: eventType,
                              onChanged: (value) {
                                setState(() {
                                  eventType = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  eventType = value;
                                });
                              },
                              dataSource:
                                  context.watch<Repository>().getEventType(),
                              textField: "display",
                              valueField: "value",
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: DateTimeFormField(
                              dateTextStyle: TextStyle(
                                fontSize: 15,
                              ),
                              onDateSelected: (DateTime date) {
                                setState(() {
                                  eventDate = date;
                                });
                              },
                              onSaved: (DateTime date) {
                                setState(() {
                                  eventDate = date;
                                });
                              },
                              firstDate: DateTime.now(),
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
                                labelText: S.current.eventDate,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: S.current.pleaseEnterValue(
                                    S.current.eventDate.toLowerCase()),
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
                              context.read<Repository>().addEvent(
                                  donationType, location, eventType, eventDate);
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
                            child: Text(S.current.addEvent,
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
    DateTime _now = DateTime.now();
    Query events = FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: _now);

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: events.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(S.current.somethingWentWrong);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(S.current.loading);
          }

          return Container(
            child: Column(
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
                    S.current.upcomingEvents,
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
                Expanded(
                  child: buildEventsListView(snapshot),
                ),
              ],
            ),
          );
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
                  await showAddEventForm(context);
                  //eventDate = null;
                  //timeOfDay = null;
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

  ListView buildEventsListView(AsyncSnapshot<QuerySnapshot> snapshot) {
    return new ListView(
                  padding: EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children:
                      snapshot.data.docs.map((DocumentSnapshot document) {
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Column(
                        children: [
                          new ListTile(
                            leading: Image.asset(
                              'assets/icons/event.png',
                            ),
                            title: new Text(
                              translation.getTranslationOfBlood(
                                  document.data()['donationType']),
                              style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            subtitle: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    new Text(
                                      document.data()['location'],
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.date_range_outlined),
                                    new Text(
                                      convertTimeStamp(
                                          document.data()['date'], true),
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.opacity),
                                    new Text(
                                      eventTypeList.singleWhere((element) =>
                                              element["value"] ==
                                              document.data()['eventType'])[
                                          "display"],
                                      style: document.data()['eventType'] ==
                                              'urgent'
                                          ? new TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 15.0,
                                              // fontWeight: FontWeight.bold,
                                            )
                                          : new TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
  }
}

String convertTimeStamp(Timestamp timestamp, bool isEvent) {
  DateTime myDateTime = timestamp.toDate();
  var newFormat =
      isEvent ? DateFormat("dd/MM/yyyy - HH:mm") : DateFormat("dd/MM/yyyy");
  String updatedDt = newFormat.format(myDateTime);
  return updatedDt;
}

String convertDate(DateTime dateTime) {
  var newFormat = DateFormat("dd/MM/yyyy");
  String updatedDt = newFormat.format(dateTime);
  return updatedDt;
}
