import 'package:donate_blood/Screens/HomeUserPage/home_page_screen.dart';
import 'package:donate_blood/Screens/Signup/signup_screen.dart';
import 'package:donate_blood/components/already_have_an_account_check.dart';
import 'package:donate_blood/components/rounded_button.dart';
import 'package:donate_blood/components/rounded_input_field.dart';
import 'package:donate_blood/components/rounded_password_field.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/background.dart';
import 'components/forgot_password_page.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage = '';

  // Check if form is valid before perform login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _email = _email.trim();
      return true;
    }
    return false;
  }

  Future<bool> _validateAndSubmit() async {
    setState(() {
      _errorMessage = '';
    });
    if (_validateAndSave()) {
      String loginResult;
      await Auth()
          .signIn(_email, _password)
          .then((value) => loginResult = value);
      if (Auth().getCurrentUser() != null &&
          Auth().getCurrentUser().uid == loginResult) {
        return true;
      } else {
        _errorMessage = loginResult;
        return false;
      }
    } else
      return false;
  }

  Widget _errorMessageWidget() {
    return SnackBar(
      content: Text(
        _errorMessage,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //key: _scaffoldKey,
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.current.login,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icons/login.webp",
                      width: size.width * 0.5,
                    ),
                  ),
                  RoundedInputField(
                    hintText: S.current.email,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  RoundedPasswordField((value) {
                    _password = value;
                  }, S.current.password),
                  Container(
                    margin: EdgeInsets.all(4.0),
                    width: size.width * 0.75,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        S.current.forgetPasswordAsk,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  RoundedButton(
                    text: S.current.login,
                    press: () {
                      _validateAndSubmit().then((value) => {
                            if (value)
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomePageScreen();
                                    },
                                  ),
                                )
                              }
                            else
                              {
                                if (_errorMessage.length > 0)
                                  //
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(_errorMessageWidget()),
                              }
                          });
                    },
                  ),
                  //_showErrorMessage(),
                  SizedBox(height: size.height * 0.02),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
