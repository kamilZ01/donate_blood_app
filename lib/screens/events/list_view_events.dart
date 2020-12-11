import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/components/build_text_form.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListViewEvents extends StatefulWidget {
  @override
  _ListViewEventsState createState() => _ListViewEventsState();
}

class _ListViewEventsState extends State<ListViewEvents> {
  Stream<DocumentSnapshot> _userData;
  String eventType;
  String location;
  String typeDonation;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  String message;
  @override
  void initState() {
    super.initState();
    _userData = context.read<Repository>().getUserData();
    message = '';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //add more form field
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BuildTextForm(S.current.eventType, eventType, (value) {
                        eventType = value;
                      }, (value) {
                        eventType = value.trim();
                      }),
                      BuildTextForm(S.current.place, location, (value) {
                        location = value;
                      }, (value) {
                        location = value.trim();
                      }),
                      BuildTextForm(S.current.donationType, typeDonation,
                          (value) {
                        typeDonation = value;
                      }, (value) {
                        typeDonation = value.trim();
                      }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 4,
                              child: selectEventDateTime(context, setState,
                                  "date", "Date", S.current.selectDate)),
                          SizedBox(width: 10.0),
                          Expanded(
                              flex: 3,
                              child: selectEventDateTime(context, setState,
                                  "time", "Time", S.current.selectTime)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(S.current.addEvent),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      context.read<Repository>().addEvent(
                          eventType, location, typeDonation, getEventDate());
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  InkWell selectEventDateTime(BuildContext context, StateSetter setState,
      String typePicker, String label, String hintText) {
    return InkWell(
      onTap: () {
        typePicker == "date"
            ? showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2200))
                .then((date) {
                setState(() {
                  dateTime = date;
                });
              })
            : showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((time) {
                setState(() {
                  timeOfDay = time;
                });
              });
      },
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: label,
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            typePicker == "date"
                ? new Text(dateTime == null ? hintText : convertDate(dateTime))
                : new Text(
                    timeOfDay == null ? hintText : timeOfDay.format(context)),
            new Icon(Icons.keyboard_arrow_down_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
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
                  child: new ListView(
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
                                document.data()['eventType'],
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
                                        document.data()['typeDonation'],
                                        style: document
                                                    .data()['typeDonation']
                                                    .toString()
                                                    .toLowerCase() ==
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
                  ),
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
                  await showInformationDialog(context);
                  dateTime = null;
                  timeOfDay = null;
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

  DateTime getEventDate() {
    return new DateTime(dateTime.year, dateTime.month, dateTime.day,
        timeOfDay.hour, timeOfDay.minute);
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
