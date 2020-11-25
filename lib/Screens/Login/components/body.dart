// import 'package:donate_blood/Screens/HomeUserPage/home_page_screen.dart';
// import 'package:donate_blood/Screens/Login/components/background.dart';
// import 'package:donate_blood/Screens/Signup/signup_screen.dart';
// import 'package:donate_blood/components/already_have_an_account_check.dart';
// import 'package:donate_blood/components/rounded_button.dart';
// import 'package:donate_blood/components/rounded_email_field.dart';
// import 'package:donate_blood/components/rounded_password_field.dart';
// import 'package:flutter/material.dart';

/*class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: Image.asset(
                  "assets/icons/login2.png",
                  width: size.width * 0.5,
                ),
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePageScreen();
                      },
                    ),
                  );
                },
              ),
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
    );
  }
}*/
/*

class Body extends StatefulWidget {
  String _email;
  String _password;

  Body(this._email, this._password);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Body body;
  // _BodyState(this.body);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: Image.asset(
                  "assets/icons/login2.png",
                  width: size.width * 0.5,
                ),
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePageScreen();
                      },
                    ),
                  );
                },
              ),
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
    );
  }
}
*/
