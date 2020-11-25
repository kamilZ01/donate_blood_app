import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/Screens/HomeUserPage/home_page_screen.dart';
import 'package:donate_blood/Screens/ProfileDetails/components/settings_page.dart';
import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:donate_blood/services/user_data.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;

  String _myActivity;
  String _myActivityResult;
  String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                            FutureBuilder(
                              future: UserData().getUserData(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  _myActivity = snapshot.data.exists ? snapshot.data.data()["bloodGroup"] : _myActivity;
                                  return Column(
                                    children: [
                                      buildTextField(S.current.fullName, snapshot.data.exists ? snapshot.data.data()["fullName"] : '', false),
                                      buildTextField("E-mail", Auth().getCurrentUser().email, true),
                                      buildTextField(S.current.phone, snapshot.data.exists ? snapshot.data.data()["phoneNumber"] : '', false),
                                      DropDownFormField(
                                        contentPadding: EdgeInsets.zero,
                                        filled: false,
                                        titleText: S.current.bloodType,
                                        hintText: S.current.pleaseChooseOne,
                                        value: _myActivity,
                                        onSaved: (value) {
                                          setState(() {
                                            _myActivity = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _myActivity = value;
                                          });
                                        },
                                        dataSource: UserData().getBloodGroups(),
                                        textField: "display",
                                        valueField: "value",
                                      ),
                                    ],
                                  );
                                } else if(snapshot.connectionState == ConnectionState.none) {
                                  return Column(
                                    children: [
                                      buildTextField(S.current.fullName, S.current.loading, false),
                                      buildTextField("E-mail", S.current.loading, true),
                                      buildTextField(S.current.phone, S.current.loading, false),
                                      DropDownFormField(
                                        contentPadding: EdgeInsets.zero,
                                        filled: false,
                                        titleText: S.current.bloodType,
                                        hintText: S.current.pleaseChooseOne,
                                        value: _myActivity,
                                        onSaved: (value) {
                                          setState(() {
                                            _myActivity = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _myActivity = value;
                                          });
                                        },
                                        dataSource: UserData().getBloodGroups(),
                                        textField: "display",
                                        valueField: "value",
                                      ),
                                    ],
                                  );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlineButton(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  highlightedBorderColor: Colors.white,
                                  onPressed: () {},
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }

                                    _formKey.currentState.save();

                                    print(_name);
                                  },
                                  color: kPrimaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "SAVE",
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
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
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        initialValue: placeholder,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: S.current.pleaseEnterValue(labelText.toLowerCase()),
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return labelText + ' is Required';
          }
          if (isEmail) {
            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Please enter a valid email Address';
            }
          }

          return null;
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }
}
