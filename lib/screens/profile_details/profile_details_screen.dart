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
import 'package:donate_blood/entities/user.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;

  String _fullName;
  String _gender;
  String _newGender;
  DateTime _dateOfBirth;
  String _phoneNumber;
  String _newBloodGroup, _bloodGroup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  Stream<DocumentSnapshot> _userData;
  List _bloodGroupsList;
  List _genderList;

  @override
  void initState() {
    super.initState();
    _newBloodGroup = '';
    _userData = context.read<Repository>().getUserData();
    _bloodGroupsList = context.read<Repository>().getBloodGroups();
    _genderList = context.read<Repository>().getGenders();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildHeaderBackground(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildEditProfileHeaderStack(context),
                  buildAvatarContainer(context),
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
                                    AsyncSnapshot<DocumentSnapshot>
                                        userDataSnapshot) {
                                  if (userDataSnapshot.hasError) {
                                    return new Text(
                                        S.current.somethingWentWrong);
                                  }
                                  if (userDataSnapshot.connectionState ==
                                      ConnectionState.active) {
                                    initEditProfileFormData(userDataSnapshot);
                                    User user = User.fromMap(
                                        userDataSnapshot.data.data());
                                    return Column(
                                      children: [
                                        buildTextField(
                                            S.current.fullName,
                                            _fullName,
                                            TextInputType.name,
                                            (value) => _fullName = value.trim(),
                                            false),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: buildGenderFormField(
                                              userDataSnapshot),
                                        ),
                                        buildTextField(
                                            S.current.phone,
                                            _phoneNumber,
                                            TextInputType.phone,
                                            (value) =>
                                                _phoneNumber = value.trim(),
                                            false),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: buildDateOfBirthFormField(),
                                        ),
                                        buildBloodTypeFormField(
                                            userDataSnapshot),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
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
                                                    _newGender == null
                                                        ? _gender
                                                        : _newGender,
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
                                                    });
                                          },
                                          child: Text(
                                            S.current.saveUpperCase,
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.2,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: kPrimaryColor,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 50,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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

  DropDownFormField buildGenderFormField(
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    return DropDownFormField(
      contentPadding: EdgeInsets.only(right: 10),
      filled: false,
      validator: (value) {
        if (snapshot.data.exists &&
            snapshot.data.data()["gender"].toString().isNotEmpty) return null;
        if (value == null) {
          return S.current.genderSelectIsRequired;
        }
        return null;
      },
      titleText: S.current.gender,
      hintText: snapshot.data.exists && snapshot.data.data()["gender"] != ""
          ? _genderList.singleWhere((element) =>
              element["value"] == snapshot.data.data()["gender"])["display"]
          : S.current.pleaseChooseOne,
      value: _newGender,
      onChanged: (value) {
        setState(() {
          _newGender = value;
        });
      },
      onSaved: (value) {
        setState(() {
          _newGender = value;
        });
      },
      dataSource: _genderList,
      textField: "display",
      valueField: "value",
    );
  }

  DateTimeFormField buildDateOfBirthFormField() {
    return DateTimeFormField(
        dateTextStyle: TextStyle(
          fontSize: 15,
        ),
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
            DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
        initialValue: _dateOfBirth,
        dateFormat: DateFormat("d MMMM y"),
        mode: DateTimeFieldPickerMode.date,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 12),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
          ),
          labelText: S.current.dateOfBirth,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText:
              S.current.pleaseEnterValue(S.current.dateOfBirth.toLowerCase()),
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            height: 2.3,
          ),
        ));
  }

  DropDownFormField buildBloodTypeFormField(
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    return DropDownFormField(
      contentPadding: EdgeInsets.only(right: 10),
      filled: false,
      validator: (value) {
        if (snapshot.data.exists &&
            snapshot.data.data()["bloodGroup"].toString().isNotEmpty)
          return null;
        if (value == null) {
          return S.current.bloodGroupSelectIsRequired;
        }
        return null;
      },
      titleText: S.current.bloodType,
      hintText: snapshot.data.exists && snapshot.data.data()["bloodGroup"] != ""
          ? snapshot.data.data()["bloodGroup"]
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
    );
  }

  Container buildAvatarContainer(BuildContext context) {
    return Container(
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
                image: AssetImage('assets/images/profileIcon.png'),
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
                  color: Theme.of(context).scaffoldBackgroundColor,
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
    );
  }

  Stack buildEditProfileHeaderStack(BuildContext context) {
    return Stack(
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
          child: buildSettingsIconButton(context),
        )
      ],
    );
  }

  IconButton buildSettingsIconButton(BuildContext context) {
    return IconButton(
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
    );
  }

  CustomPaint buildHeaderBackground(BuildContext context) {
    return CustomPaint(
      child: Container(
        margin: EdgeInsets.only(top: 55),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      painter: HeaderCurvedContainer(),
    );
  }

  Widget buildTextField(String labelText, String hintValue,
      TextInputType typeValue, ValueChanged<String> onChanged, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        keyboardType: typeValue,
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

  void initEditProfileFormData(
      AsyncSnapshot<DocumentSnapshot> userDataSnapshot) {
    _fullName = userDataSnapshot.data.exists
        ? userDataSnapshot.data.data()["fullName"]
        : S.current.loading;
    _gender = userDataSnapshot.data.exists
        ? userDataSnapshot.data.data()["gender"]
        : S.current.loading;
    _phoneNumber = userDataSnapshot.data.exists
        ? userDataSnapshot.data.data()["phoneNumber"]
        : S.current.loading;
    Timestamp dateOfBirth = userDataSnapshot.data.exists &&
            userDataSnapshot.data.data()["dateOfBirth"].toString().isNotEmpty
        ? userDataSnapshot.data.data()["dateOfBirth"]
        : null;
    _dateOfBirth = dateOfBirth != null ? dateOfBirth.toDate() : null;
    _bloodGroup = userDataSnapshot.data.exists
        ? userDataSnapshot.data.data()["bloodGroup"]
        : S.current.loading;
  }
}
