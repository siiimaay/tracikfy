import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/company_details_view.dart';
import 'package:trackify/features/company/presentation/company_view.dart';
import 'package:trackify/features/company/presentation/widgets/employee_image_widget.dart';
import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final Color? color;
  final String? label;
  final Function()? onTap;

  const Frame({
    Key? key,
    this.color,
    this.onTap,
     this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go("${CompanyView.route}/${CompanyDetailView.route}"),
      child: Container(
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
                EmployeeInfoWidget(),
                EmployeeInfoWidget(),
                EmployeeInfoWidget(),
                EmployeeInfoWidget(),
              ],
            ),
          ],
        ),
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
