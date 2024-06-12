import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/company_detail_bloc/company_detail_bloc.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';

import '../../../../core/injection/locator.dart';
import '../../../../global/multi_select_dropdown.dart';
import '../../../../global/single_select_dropdown.dart';
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
  bool shouldEnable = false;
  String? workArea;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyNameController.addListener(() {
      if (companyNameController.text.isNotEmpty) {
        setState(() {
          shouldEnable = true;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        backgroundColor: context.color.settingsBackColor,
        title: const Text("Company Details"),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<CompanyDetailBloc>(),
        child: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "| Add new Company",
                                style: context.textStyle.detailText.copyWith(
                                    color: context.color.appThemeMainColor,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CompanyDetailSection(
                                settingsItems: [
                                  DetailItem(
                                    text: "Company name",
                                    valueText: "",
                                    prefixIcon: Icon(
                                      Icons.account_balance_outlined,
                                      color: const Color(0xff09093b)
                                          .withOpacity(0.7),
                                    ),
                                    textEditingController:
                                        companyNameController,
                                  ),
                                  SingleSelectDropdown(
                                    items: [
                                      "Engineering",
                                      "Product",
                                      "Tech",
                                      "Technology"
                                    ].toList(),
                                    isReadOnly: false,
                                    hint: 'Select department',
                                    itemNameBuilder: (dynamic item) {
                                      return item;
                                    },
                                    onSelectedItemChanged: (String? comp) {
                                     setState(() {
                                       workArea = comp ?? "N/A";
                                     });
                                    },
                                    selectedItem: workArea,
                                  ),
                                  DetailItem(
                                      text: "Co-Founder ",
                                      valueText: "",
                                      prefixIcon: Icon(
                                        Icons.contact_mail_outlined,
                                        color: const Color(0xff09093b)
                                            .withOpacity(0.7),
                                      ),
                                      textEditingController:
                                          contactInfoController),
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
                              if (shouldEnable) {
                                context.read<CompanyDetailBloc>().add(
                                    CompanyDetailEvent.save(Company(
                                        company: companyNameController.text,
                                        workArea:workArea ?? "N/A",
                                        phoneNo: contactInfoController.text)));
                              }
                            },
                            color: (shouldEnable)
                                ? const Color(0xff09093b)
                                : const Color(0xffD3D3D3)))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
