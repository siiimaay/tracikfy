import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/candidate/bloc/employee_bloc.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';
import 'package:trackify/features/candidate/widgets/employee_status_selection_widget.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';
import 'package:trackify/global/expandable_section.dart';

import '../../../global/checkbox.dart';
import '../../../global/multi_select_dropdown.dart';
import '../../../global/single_select_dropdown.dart';
import '../../../global/submit_button.dart';
import '../../company/data/company.dart';
import '../data/employee.dart';

class EmployeeDetailView extends StatefulWidget {
  static const route = "employee_detail_view";

  const EmployeeDetailView({super.key});

  @override
  State<EmployeeDetailView> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController workAreaController = TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        title: const Text("Employee Details"),
        actions: const [
          /* PopupMenuButton(itemBuilder: (BuildContext context) {
            return PopupMenuItem(child: Text("hy"),);
          },)*/
        ],
        surfaceTintColor: context.color.settingsBackColor,
        shadowColor: context.color.settingsBackColor,
      ),
      body: BlocProvider(
        create: (context) => EmployeeBloc(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              KeyboardVisibilityBuilder(builder: (context, isVisible) {
                return SingleChildScrollView(
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
                        if (!isVisible)
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
                            textEditingController: employeeNameController,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: MultiSelectDropdown(
                              items: [
                                "Engineering",
                                "Product",
                                "Engineering",
                                "Product"
                              ].toList(),
                              hint: 'Select department',
                              onSelectedItemsChanged: (items) {
                                context.read<EmployeeBloc>().add(
                                    EmployeeDetailEvent.selectDepartment(
                                        items));
                              },
                              selectedItems: List.empty(growable: true),
                              itemNameBuilder: (dynamic item) {
                                return item;
                              },
                            ),
                          ),
                          BlocBuilder<EmployeeBloc, EmployeeDetailState>(
                            buildWhen: (o, n) =>
                            o.companies != n.companies ||
                                o.selectedCompany != n.selectedCompany,
                            builder: (context, state) {
                              return Flexible(
                                fit: FlexFit.loose,
                                child: SingleSelectDropdown(
                                  items: state.companies,
                                  hint: 'Select company',
                                  onSelectedItemChanged: (item) {
                                    context.read<EmployeeBloc>().add(
                                        EmployeeDetailEvent.selectCompany(
                                            (item as Company)));
                                  },
                                  selectedItem: state.selectedCompany,
                                  onLoad: () =>
                                      context
                                          .read<EmployeeBloc>()
                                          .add(const EmployeeDetailEvent
                                          .fetchCompanies()),
                                  itemNameBuilder: (dynamic item) {
                                    final companyName =
                                        (item as Company).company;
                                    return companyName;
                                  },
                                ),
                              );
                            },
                          ),
                          EmployeeSelectionStatus(
                            onTap: (value) {
                              context.read<EmployeeBloc>().add(
                                  EmployeeDetailEvent.selectStatus(value));
                            },
                          )
                        ]),
                      ],
                    ),
                  ),
                );
              }),
              BlocBuilder<EmployeeBloc, EmployeeDetailState>(
                builder: (context, state) {
                  return Positioned(
                      bottom: 0,
                      child: SubmitButton(
                        buttonText: 'Update',
                        onPressed: () {
                          context.read<EmployeeBloc>().add(
                              EmployeeDetailEvent.save(Employee(
                                  name: employeeNameController.text,
                                  status: EmployeeStatus.active,
                                  department: state.selectedDepartment,
                                  companyId: state.selectedCompany?.id)));
                        },
                        color: const Color(0xff09093b),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
