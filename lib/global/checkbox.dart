import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final String title;
  final Color textColor;
  final Color radioButtonColor;
  final Color selectedColor;
  final String? groupValue;
  final Function(String)? onChanged;

  RadioButton({
    required this.title,
    required this.textColor,
    required this.radioButtonColor,
    required this.selectedColor,
    required this.groupValue,
    this.onChanged,
  });

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      splashRadius: 0,
      title: Text(
        widget.title,
        style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500),
      ),
      value: widget.title,
      groupValue: widget.groupValue,
      activeColor: widget.radioButtonColor,
      onChanged: (newValue) {
        if (widget.onChanged != null) {
          widget.onChanged!(newValue!);
        }
      },
    );
  }
}
