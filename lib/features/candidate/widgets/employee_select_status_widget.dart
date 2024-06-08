import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

import '../data/employee_status.dart';

class ButtonSelectionPage extends StatefulWidget {
  final EmployeeStatus? selectedStatus;

  const ButtonSelectionPage({super.key, this.selectedStatus});

  @override
  ButtonSelectionPageState createState() => ButtonSelectionPageState();
}

class ButtonSelectionPageState extends State<ButtonSelectionPage> {
  EmployeeStatus? _selectedIndex; // No button is selected initially

  void _onButtonPressed(EmployeeStatus status) {
    setState(() {
      _selectedIndex = status;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectableButton(
          status: EmployeeStatus.active,
          selectedStatus: _selectedIndex,
          onPressed: _onButtonPressed,
          text: EmployeeStatus.active.name,
        ),
        const SizedBox(width: 16),
        SelectableButton(
          status: EmployeeStatus.interviewing,
          selectedStatus: _selectedIndex,
          onPressed: _onButtonPressed,
          text: EmployeeStatus.interviewing.name,
        ),
        const SizedBox(width: 16),
        SelectableButton(
          status: EmployeeStatus.onboarding,
          selectedStatus: _selectedIndex,
          onPressed: _onButtonPressed,
          text: EmployeeStatus.onboarding.name
        ),
      ],
    );
  }
}

class SelectableButton extends StatelessWidget {
  final EmployeeStatus status;
  final EmployeeStatus? selectedStatus;
  final Function(EmployeeStatus) onPressed;
  final String text;

  const SelectableButton({
    super.key,
    required this.status,
    required this.selectedStatus,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: selectedStatus == status
            ? context.color.appThemeMainColor
            : const Color(0xffD3D3D3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: const Size(100, 50),
      ),
      onPressed: () => onPressed(status),
      child: Text(text ?? "ACTIVE"),
    );
  }
}
