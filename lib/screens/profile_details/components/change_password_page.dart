import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_password_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/screens/login/login_screen.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donate_blood/components/background.dart';
import 'package:move_to_background/move_to_background.dart';
import '../../../constants.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword;
  String _confirmNewPassword;
  String _currentPassword;
  String _errorMessage = '';
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate() && _newPassword == _confirmNewPassword && _newPassword != _currentPassword) {
      _newPassword = _newPassword.trim();
      return true;
    } else if(form.validate() && _newPassword == _currentPassword){
      _errorMessage = S.current.newPasswordEqualCurrentPassword;
      return false;
    } else if(form.validate()){
      _errorMessage = S.current.differentPassword;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: kPrimaryColor,
              ),
            ),
          ),
          body: Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.current.changePassword.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/icons/login.webp",
                        width: size.width * 0.5,
                      ),
                    ),
                    RoundedPasswordField((value) {
                      _currentPassword = value;
                    }, S.current.currentPassword, false),
                    RoundedPasswordField((value) {
                      _newPassword = value;
                    }, S.current.newPassword, true),
                    RoundedPasswordField((value) {
                      _confirmNewPassword = value;
                    }, S.current.confirmNewPassword, false),
                    RoundedButton(
                        text: S.current.changePassword.toUpperCase(),
                        press: () async {
                          if (_validateAndSave()) {
                            await Auth()
                                .changePassword(_currentPassword, _newPassword)
                                .then((value) => {
                                      if (value == S.current.changedPassword)
                                        {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return AlertDialog(
                                                title: new Text(S.current.changePassword),
                                                content: new Text(S.current.changedPassword),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text(S.current.goToLogin),
                                                    onPressed: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                        return LoginScreen();
                                                      }));
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        }
                                      else if (value.isNotEmpty &&
                                          value.length > 0)
                                        {
                                          _scaffoldMessengerKey.currentState
                                              .showSnackBar(
                                                  SnackBar(content: Text(value)))
                                        },
                                    });
                          } else {
                            if(_errorMessage.isNotEmpty && _errorMessage.length > 0){
                              _scaffoldMessengerKey.currentState.showSnackBar(SnackBar(content: Text(_errorMessage),));
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      }
    );
  }
}
