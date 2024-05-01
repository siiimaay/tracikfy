import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';
import 'package:trackify/global/checkbox.dart';

class EmployeeSelectionStatus extends StatefulWidget {
  final Function(String value) onTap;
  const EmployeeSelectionStatus({Key? key, required this.onTap}) : super(key: key);

  @override
  State<EmployeeSelectionStatus> createState() => _EmployeeSelectionStatusState();
}

class _EmployeeSelectionStatusState extends State<EmployeeSelectionStatus> {
  String selectedOption = 'Checkbox 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RadioButton(
          title: EmployeeStatus.active.name,
          textColor: const Color(0xff8b0000),
          selectedColor: const Color(0xff8b0000).withOpacity(0.3),
          radioButtonColor: const Color(0xff8b0000),
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
            });
            widget.onTap.call(value);
          },
        ),
        RadioButton(
          title: EmployeeStatus.interviewing.name,
          textColor: const Color(0xff663399),
          selectedColor: const Color(0xff663399).withOpacity(0.3),
          radioButtonColor: const Color(0xff663399),
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
            });
            widget.onTap.call(value);
          },
        ),
        RadioButton(
          title: EmployeeStatus.onboarding.name,
          textColor: const Color(0xff228b22),
          selectedColor: const Color(0xff228b22).withOpacity(0.3),
          radioButtonColor: const Color(0xff228b22),
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
            });
            widget.onTap.call(value);
          },
        ),

      ],
    );
  }
}
