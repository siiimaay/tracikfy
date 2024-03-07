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
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Wrap(
        children: [
          EmployeeImageWidget(),

        ],
      ),
    );
  }
}
