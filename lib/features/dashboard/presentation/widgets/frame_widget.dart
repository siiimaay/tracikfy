import 'dart:math';

import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/widgets/employee_image_widget.dart';
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
          border: Border.all(color: _getRandomColor(), width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company name (4)",
            style: context.textStyle.companyNameText,
            softWrap: true,
          ),
          const SizedBox(height: 8),
          const Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 15,
            children: [
              EmployeeImageWidget(),
              EmployeeImageWidget(),
              EmployeeImageWidget(),
              EmployeeImageWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

Color _getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}
