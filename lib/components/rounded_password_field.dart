import 'package:donate_blood/Screens/Login/login_screen.dart';
import 'package:donate_blood/components/text_field_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  RoundedPasswordField(this.onChanged);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        obscureText: !_passwordVisible,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: S.current.password,
          border: InputBorder.none,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            splashRadius: 1,
            icon: Icon(
              Icons.visibility,
              color: kPrimaryColor
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) => value.isEmpty ? S.current.passwordEmpty : null,
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
