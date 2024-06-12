import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/company_cubit/company_cubit.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';
import 'package:trackify/global/expandable_section.dart';

import '../../../../global/multi_select_dropdown.dart';
import '../../../../global/submit_button.dart';
import '../../data/company.dart';

class CompanyDetailView extends StatefulWidget {
  final Company company;
  static const route = "company_detail_view";

  const CompanyDetailView({super.key, required this.company});

  @override
  State<CompanyDetailView> createState() => _CompanyDetailViewState();
}

class _CompanyDetailViewState extends State<CompanyDetailView> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController executiveNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyNameController.text = widget.company.company;
    executiveNameController.text = widget.company.workArea;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: const Text("Company Details"),
        surfaceTintColor: context.color.settingsBackColor,
        shadowColor: context.color.settingsBackColor,
      ),
      body: Material(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* const Center(
                          child: CircleAvatar(
                        maxRadius: 75,
                        backgroundColor: Colors.grey,
                      )),*/
                      const SizedBox(height: 16),
                      CompanyDetailSection(settingsItems: [
                        DetailItem(
                          text: "Company name",
                          valueText: widget.company.company,
                          prefixIcon: Icon(
                            Icons.account_balance_outlined,
                            color: const Color(0xff09093b).withOpacity(0.7),
                          ),
                          textEditingController: companyNameController,
                        ),
                        MultiSelectDropdown(
                          items: [
                            "Engineering",
                            "Product",
                            "Engineering",
                            "Product"
                          ].toList(),
                          isReadOnly: true,
                          hint: 'Select department',
                          onSelectedItemsChanged: (items) {
                            /*context.read<EmployeeBloc>().add(
                                    EmployeeDetailEvent.selectDepartment(
                                        items));*/
                          },
                          selectedItems: [widget.company.workArea],
                          itemNameBuilder: (dynamic item) {
                            return item;
                          },
                        ),
                        DetailItem(
                          text: "Co-Founder",
                          valueText: widget.company.phoneNo,
                          prefixIcon: Icon(
                            Icons.contact_mail_outlined,
                            color: const Color(0xff09093b).withOpacity(0.7),
                          ),
                          textEditingController: executiveNameController,
                        ),
                      ]),
                      const Expanded(
                        child: ExpandableSection(sectionName: "Team"),
                      ),
                    ],
                  ),
                ),
              ),
              BlocProvider<CompanyCubit>(
                create: (ctx) => CompanyCubit(),
                child: Builder(
                  builder: (context) {
                    return Positioned(
                        bottom: 0,
                        child: SubmitButton(
                          buttonText: 'Update',
                          onPressed: () {
                            context.read<CompanyCubit>().updateCompany(Company(
                                id: widget.company.id,
                                userId: widget.company.userId,
                                company: companyNameController.text,
                                workArea: widget.company.workArea,
                                phoneNo: executiveNameController.text));
                          },
                          color: const Color(0xff09093b),
                        ));
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
