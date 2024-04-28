import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/company_detail_bloc/company_detail_bloc.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';

import '../../../../core/injection/locator.dart';
import '../../../../global/submit_button.dart';
import '../../data/company.dart';

class NewCompanyDetailForm extends StatefulWidget {
  static const route = "new_company_view";

  const NewCompanyDetailForm({super.key});

  @override
  State<NewCompanyDetailForm> createState() => _NewCompanyDetailFormState();
}

class _NewCompanyDetailFormState extends State<NewCompanyDetailForm> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController workAreaController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: Text("Company Details"),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<CompanyDetailBloc>(),
        child: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, state) {
            return Container(
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
                                    color: const Color(0xff09093b)
                                        .withOpacity(0.7),
                                  ),
                                  textEditingController: companyNameController,
                                ),
                                DetailItem(
                                  text: "Work Area",
                                  valueText: "Value",
                                  prefixIcon: Icon(
                                    Icons.work_history_outlined,
                                    color: const Color(0xff09093b)
                                        .withOpacity(0.7),
                                  ),
                                  textEditingController: workAreaController,
                                ),
                                DetailItem(
                                  text: "Urgency Contact People",
                                  valueText: "Value",
                                  prefixIcon: Icon(
                                    Icons.contact_mail_outlined,
                                    color: const Color(0xff09093b)
                                        .withOpacity(0.7),
                                  ),
                                  textEditingController: contactInfoController,
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: SubmitButton(
                        buttonText: 'Save',
                        onPressed: () {
                          context.read<CompanyDetailBloc>().add(
                              CompanyDetailEvent.save(Company(
                                  company: companyNameController.text,
                                  workArea: workAreaController.text,
                                  phoneNo: contactInfoController.text)));
                        },
                        color: const Color(0xff09093b),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
