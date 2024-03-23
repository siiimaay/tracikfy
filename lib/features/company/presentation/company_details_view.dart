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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: CircleAvatar(
            maxRadius: 75,
            backgroundColor: Colors.grey,
          )),
          const SizedBox(height: 16),
          CompanyDetailSection(sectionName: "Company Details", settingsItems: [
            DetailItem(
              text: "Company name",
              valueText: "Value",
              prefixIcon: Icon(
                Icons.account_balance_outlined,
                color: const Color(0xff09093b).withOpacity(0.7),
              ),
            ),
            DetailItem(
                text: "Work Area",
                valueText: "Value",
                prefixIcon: Icon(
                  Icons.work_history_outlined,
                  color: const Color(0xff09093b).withOpacity(0.7),
                )),
            DetailItem(
                text: "Contact information",
                valueText: "Value",
                prefixIcon: Icon(
                  Icons.contact_mail_outlined,
                  color: const Color(0xff09093b).withOpacity(0.7),
                )),
          ]),
        ],
      ),
    );
  }
}
