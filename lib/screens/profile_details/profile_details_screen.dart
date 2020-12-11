import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/repository.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/settings_page.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;

  String _fullName;
  DateTime _dateOfBirth;
  String _phoneNumber;
  String _newBloodGroup, _bloodGroup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  Stream<DocumentSnapshot> _userData;
  List _bloodGroupsList;

  @override
  void initState() {
    super.initState();
    _newBloodGroup = '';
    _userData = context.read<Repository>().getUserData();
    _bloodGroupsList = context.read<Repository>().getBloodGroups();
    //context.read<Repository>().getUsersMap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        /*appBar: AppBar(
          elevation: 1,
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePageScreen()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),*/
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomPaint(
                child: Container(
                  margin: EdgeInsets.only(top: 55),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            S.current.editProfile,
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                            // size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SettingsPage();
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/profileIcon.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          // left: width * 0.39,
                          // top: height * 0.20,
                          bottom: 20,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.grey,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              iconSize: 15,
                              onPressed: () {
                                setState(() {
                                  print("test");
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          child: Column(
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                stream: _userData,
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    _fullName = snapshot.data.exists
                                        ? snapshot.data.data()["fullName"]
                                        : S.current.loading;
                                    _phoneNumber = snapshot.data.exists
                                        ? snapshot.data.data()["phoneNumber"]
                                        : S.current.loading;
                                    Timestamp dateOfBirth = snapshot.data.exists
                                        ? snapshot.data.data()["dateOfBirth"]
                                        : null;
                                    _dateOfBirth = dateOfBirth != null
                                        ? dateOfBirth.toDate()
                                        : null;
                                    _bloodGroup = snapshot.data.exists
                                        ? snapshot.data.data()["bloodGroup"]
                                        : S.current.loading;
                                    return Column(
                                      children: [
                                        buildTextField(
                                            S.current.fullName,
                                            _fullName,
                                            (value) => _fullName = value.trim(),
                                            false),
                                        //buildTextField("E-mail", _email, (value) => _email = value.trim(), true),
                                        buildTextField(
                                            S.current.phone,
                                            _phoneNumber,
                                            (value) =>
                                                _phoneNumber = value.trim(),
                                            false),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: DateTimeFormField(
                                              /*textStyle: TextStyle(
                                                fontSize: 20,
                                              ),*/
                                              onDateSelected: (DateTime date) {
                                                setState(() {
                                                  _dateOfBirth = date;
                                                });
                                              },
                                              onSaved: (DateTime date) {
                                                setState(() {
                                                  _dateOfBirth = date;
                                                });
                                              },
                                              lastDate: DateTime(
                                                  DateTime.now().year - 18,
                                                  DateTime.now().month,
                                                  DateTime.now().day),
                                              initialValue: _dateOfBirth,
                                              dateFormat:
                                                  DateFormat("d MMMM y"),
                                              mode: DateFieldPickerMode.date,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 12),
                                                suffixIcon: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8.0),
                                                  child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color:
                                                          Colors.grey.shade700),
                                                ),
                                                labelText:
                                                    S.current.dateOfBirth,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                hintText: S.current
                                                    .pleaseEnterValue(S
                                                        .current.dateOfBirth
                                                        .toLowerCase()),
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  height: 2.3,
                                                ),
                                              )),
                                        ),
                                        DropDownFormField(
                                          contentPadding:
                                              EdgeInsets.only(right: 10),
                                          filled: false,
                                          validator: (value) {
                                            if (snapshot.data.exists &&
                                                snapshot.data
                                                    .data()["bloodGroup"]
                                                    .toString()
                                                    .isNotEmpty) return null;
                                            if (value == null) {
                                              return S.current
                                                  .bloodGroupSelectIsRequired;
                                            }
                                            return null;
                                          },
                                          titleText: S.current.bloodType,
                                          hintText: snapshot.data.exists
                                              ? snapshot.data
                                                  .data()["bloodGroup"]
                                              : S.current.pleaseChooseOne,
                                          value: _newBloodGroup,
                                          onChanged: (value) {
                                            setState(() {
                                              _newBloodGroup = value;
                                            });
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              _newBloodGroup = value;
                                            });
                                          },
                                          dataSource: _bloodGroupsList,
                                          textField: "value",
                                          valueField: "value",
                                          /*dataSource: context.watch<Repository>().getUsersList(),
                                          textField: "display",
                                          valueField: "value",*/
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        RaisedButton(
                                          onPressed: () async {
                                            if (!_formKey.currentState
                                                .validate()) {
                                              return;
                                            } else
                                              _formKey.currentState.save();
                                            await context
                                                .read<Repository>()
                                                .updateUser(
                                                    _fullName,
                                                    _dateOfBirth,
                                                    _phoneNumber,
                                                    _newBloodGroup == null
                                                        ? _bloodGroup
                                                        : _newBloodGroup)
                                                .then((value) => {
                                                      if (value.isNotEmpty &&
                                                          value.length > 0)
                                                        _scaffoldMessengerKey
                                                            .currentState
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(value),
                                                        ))
                                                    })
                                                .catchError((error) =>
                                                    _scaffoldMessengerKey
                                                        .currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(error
                                                                .toString()))));
                                          },
                                          color: kPrimaryColor,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 50,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            S.current.saveUpperCase,
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  }

                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String hintValue,
      ValueChanged<String> onChanged, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        initialValue: hintValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintValue.isEmpty
              ? S.current.pleaseEnterValue(labelText.toLowerCase())
              : hintValue,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value.isEmpty && hintValue == S.current.loading) {
            return labelText + S.current.isRequired;
          }
          if (isEmail && hintValue == S.current.loading) {
            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return S.current.pleaseEnterAValidEmailAddress;
            }
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
