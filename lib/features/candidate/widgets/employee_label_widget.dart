import 'package:flutter/material.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';

class EmployeeStatusLabel extends StatelessWidget {
  final String? status;
  final bool shouldShowIcon;

  const EmployeeStatusLabel(
      {super.key, this.status, this.shouldShowIcon = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30,
          width: 100,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: status != null
                  ? _getColor(EmployeeStatus.fromString(status!)!)
                  : Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24)),
          child: Center(
            child: Text(
              (status != null && status?.isNotEmpty == true)
                  ? (status ?? "ACTIVE")
                  : "ACTIVE",
              style: TextStyle(
                  color: status != null
                      ? _getTextColor(EmployeeStatus.fromString(status!)!)
                      : Colors.blue,
                  fontSize: 13),
            ),
          ),
        ),
        if (shouldShowIcon)
          Positioned(
            top: -1,
            left: -2,
            child: Transform.rotate(
              angle: 45,
              child:  Icon(
                Icons.attachment_outlined,
                color: status != null
                    ? _getTextColor(EmployeeStatus.fromString(status!)!)
                    : Colors.blue,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }

  Color _getColor(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return Colors.green.withOpacity(0.2);
      case EmployeeStatus.rejected:
      case EmployeeStatus.deactivated:
        return Colors.red.withOpacity(0.2);
      case EmployeeStatus.interviewing:
        return Colors.indigoAccent.withOpacity(0.2);
      case EmployeeStatus.onboarding:
        return Colors.blue.withOpacity(0.2);
    }
  }

  Color _getTextColor(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return Colors.green;
      case EmployeeStatus.rejected:
      case EmployeeStatus.deactivated:
        return Colors.red;
      case EmployeeStatus.interviewing:
        return Colors.indigoAccent;
      case EmployeeStatus.onboarding:
        return Colors.blue;
    }
  }
}
