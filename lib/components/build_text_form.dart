import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextForm extends StatefulWidget {
  final String label;
  final String fieldValue;
  final TextInputType typeValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;
  final InputDecoration inputDecoration;

  BuildTextForm(
      this.label, this.fieldValue, this.typeValue, this.onChanged, this.onSaved,
      [this.inputDecoration]);

  @override
  _BuildTextFormState createState() => _BuildTextFormState();
}

class _BuildTextFormState extends State<BuildTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
        keyboardType: widget.typeValue,
        validator: (value) {
          return value.isEmpty ? S.current.invalidField : null;
        },
        inputFormatters: widget.typeValue == TextInputType.number
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ]
            : null,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        decoration: widget.inputDecoration != null
            ? widget.inputDecoration
            : InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                labelText: widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.typeValue == TextInputType.number
                    ? S.current.enterAmount
                    : S.current.enterText,
                hintStyle: TextStyle(height: 2),
              ),
      ),
    );
  }
}
