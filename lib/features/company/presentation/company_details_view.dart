import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';
import 'package:trackify/global/expandable_section.dart';

import '../../../global/submit_button.dart';

class CompanyDetailView extends StatelessWidget {
  static const route = "company_detail_view";

  const CompanyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: const Text("Company Details"),
        surfaceTintColor: context.color.settingsBackColor,
        shadowColor: context.color.settingsBackColor,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Stack(
            alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                        child: CircleAvatar(
                      maxRadius: 75,
                      backgroundColor: Colors.grey,
                    )),
                    const SizedBox(height: 16),
                    CompanyDetailSection(
                        sectionName: "Company Details",
                        settingsItems: [
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
                    const Expanded(
                      child: ExpandableSection(sectionName: "Employees"),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,

                child: SubmitButton(
                  buttonText: 'Update',
                  onPressed: () {},
                  color: const Color(0xff09093b),
                ))
          ],
        ),
      ),
    );
  }
}
