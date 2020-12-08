import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';

class BuildTextForm extends StatefulWidget {
  final String label;
  final String fieldValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;

  BuildTextForm(this.label, this.fieldValue, this.onChanged, this.onSaved);

  @override
  _BuildTextFormState createState() => _BuildTextFormState();
}

class _BuildTextFormState extends State<BuildTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        validator: (value) {
          return value.isEmpty ? "Invalid Field" : null;
        },
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.only(bottom: 2),
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: S.current.enterSomeText,
          hintStyle: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
