import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';

class CompanyDetailView extends StatelessWidget {
  static const route = "/company_detail_view";

  const CompanyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: const Text("Company Details"),
      ),
      body:  const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: CircleAvatar(
            maxRadius: 75,
            backgroundColor: Colors.grey,
          )),
          SizedBox(height: 16),
          CompanyDetailSection(sectionName: "Company Details", settingsItems: [
            DetailItem(
              text: "Company name",
              valueText: "Value",
              prefixIcon: Icon(Icons.account_balance_rounded),
            ),
            DetailItem(
                text: "Work Area",
                valueText: "Value",
                prefixIcon: Icon(Icons.work_history_outlined)),
            DetailItem(
                text: "Contact information",
                valueText: "Value",
                prefixIcon: Icon(Icons.contact_mail_outlined)),
          ]),

        ],
      ),
    );
  }
}
