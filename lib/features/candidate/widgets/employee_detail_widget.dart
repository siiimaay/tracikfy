import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';
import 'package:trackify/global/expandable_section.dart';

import '../../../global/multi_select_dropdown.dart';
import '../../../global/submit_button.dart';

class EmployeeDetailView extends StatelessWidget {
  static const route = "employee_detail_view";

  const EmployeeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: const Text("Employee Details"),
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
                    CompanyDetailSection(settingsItems: [
                      DetailItem(
                        text: "Employee name",
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
                    Flexible(
                      child: MultiSelectDropdown(
                        items: ["Engineering", "Product","Engineering", "Product"].toList(),
                        hint: 'Select department',
                        onSelectedItemsChanged: (_) {},
                        selectedItems: const ["Engineering","Product"].toList(),
                        itemNameBuilder: (String item) {
                          return item;
                        },
                      ),
                    )
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
