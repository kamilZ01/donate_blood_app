import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/components/text_field_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  bool signUpForm;

  RoundedPasswordField(this.onChanged, this.hintText, this.signUpForm);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible = false;

  //IconData _iconPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        textAlignVertical: TextAlignVertical.center,
        obscureText: !_passwordVisible,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            splashRadius: 1,
            icon: _passwordVisible
                ? Icon(Icons.visibility_off, color: kPrimaryColor)
                : Icon(Icons.visibility, color: kPrimaryColor),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value.isEmpty) return S.current.passwordEmpty;

          if (widget.signUpForm) {
            if (value.length < 8) {
              return 'Password should contain min 8 characters';
            }
          }
          return null;
        },
      ),
    );
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
}
