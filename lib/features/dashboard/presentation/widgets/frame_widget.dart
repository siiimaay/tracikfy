import 'package:feelify/features/company/presentation/widgets/employee_image_widget.dart';
import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final Color? color;
  final String label;

  const Frame({
    Key? key,
    this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: const Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 15,
        children: [
          EmployeeImageWidget(),
          EmployeeImageWidget(),
          EmployeeImageWidget(),
          EmployeeImageWidget(),
        ],
      ),
    );
  }
}
