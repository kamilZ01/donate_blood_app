import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewEvents extends StatefulWidget {
  @override
  _ListViewEventsState createState() => _ListViewEventsState();
}

class _ListViewEventsState extends State<ListViewEvents> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //add more form field
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration:
                            InputDecoration(hintText: "Enter Some Text"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choice Box"),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
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
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
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
                  // padding: EdgeInsets.all(70.0),
                  child: Text(
                    "Upcoming Events",
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
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20.0),
                        //   border: Border.all(
                        //     color: Colors.purple[100],
                        //   ),
                        // ),
                        margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                        child: Column(
                          children: [
                            new ListTile(
                              leading: CircleAvatar(
                                child: Image.asset('assets/icons/event.png'),
                                backgroundColor: Colors.white,
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
                                            document.data()['date']),
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
                                                    .toString() ==
                                                'Urgent'
                                            ? new TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 15.0,
                                                // fontWeight: FontWeight.bold,
                                              )
                                            : new TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  // new Text("Date: " +
                                  //     convertTimeStamp(document.data()['created'])),
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
        stream: UserData().getUserData(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Map isN = snapshot.data.data();
            if (snapshot.data.exists && snapshot.data.data()['isNurse'])
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await showInformationDialog(context);
                },
                backgroundColor: Colors.red,
              );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("something went wrong!");
          }
          return Container();
        },
      ),
    );
  }
}

String convertTimeStamp(Timestamp timestamp) {
  DateTime myDateTime = timestamp.toDate();
  var newFormat = DateFormat("dd/MM/yyyy - HH:mm");
  String updatedDt = newFormat.format(myDateTime);
  return updatedDt;
}
