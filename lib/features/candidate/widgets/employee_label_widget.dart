import 'package:flutter/material.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';

class EmployeeStatusLabel extends StatelessWidget {
  final EmployeeStatus? status;
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
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24)),
          child: Center(
            child: Text(
              status?.name ?? "ACTIVE",
              style: const TextStyle(color: Colors.blue, fontSize: 13),
            ),
          ),
        ),
        if (shouldShowIcon)
          Positioned(
            top: -1,
            left: -3,
            child: Transform.rotate(
              angle: 45,
              child: const Icon(
                Icons.attachment_outlined,
                color: Colors.blue,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}
