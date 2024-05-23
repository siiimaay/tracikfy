import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/candidate/bloc/employee_bloc.dart';
import 'package:trackify/features/candidate/widgets/employee_select_status_widget.dart';
import 'package:trackify/features/company/presentation/widgets/company_detail_section.dart';
import 'package:trackify/features/company/presentation/widgets/detail_item.dart';

import '../../../global/multi_select_dropdown.dart';
import '../../../global/single_select_dropdown.dart';
import '../../../global/submit_button.dart';
import '../../company/data/company.dart';
import '../data/employee.dart';
import '../data/employee_status.dart';
import '../data/employee_ui_model.dart';

class ExistingEmployeeDetailView extends StatefulWidget {
  final EmployeeData employee;
  static const route = "existing_employee_detail_view";

  const ExistingEmployeeDetailView({super.key, required this.employee});

  @override
  State<ExistingEmployeeDetailView> createState() =>
      _ExistingEmployeeDetailViewState();
}

class _ExistingEmployeeDetailViewState
    extends State<ExistingEmployeeDetailView> {
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
              BlocBuilder<EmployeeBloc, EmployeeDetailState>(
                builder: (context, state) {
                  return KeyboardVisibilityBuilder(
                      builder: (context, isVisible) {
                    return SingleChildScrollView(
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
                                widget.employee.name,
                                style: context.textStyle.detailText.copyWith(
                                    color: context.color.appThemeMainColor,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ButtonSelectionPage(
                              selectedStatus: EmployeeStatus.fromString(
                                  widget.employee.status),
                            ),
                            const SizedBox(height: 16),
                            CompanyDetailSection(
                                sectionName: "Title",
                                settingsItems: [
                                  DetailItem(
                                    text: "",
                                    valueText: "widget.employee.status",
                                    //TODO: should be title,
                                    prefixIcon: Icon(
                                      Icons.account_balance_outlined,
                                      color: const Color(0xff09093b)
                                          .withOpacity(0.7),
                                    ),
                                    textEditingController:
                                        employeeNameController,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: SingleSelectDropdown(
                                      items: state.companies,
                                      hint: 'Select company',
                                      onSelectedItemChanged: (item) {
                                        context.read<EmployeeBloc>().add(
                                            EmployeeDetailEvent.selectCompany(
                                                (item as Company)));
                                      },
                                      isReadOnly: true,
                                      selectedItem: state.companies.firstWhere(
                                          (element) =>
                                              element.id ==
                                              widget.employee.companyId),
                                      onLoad: () => context
                                          .read<EmployeeBloc>()
                                          .add(const EmployeeDetailEvent
                                              .fetchCompanies()),
                                      itemNameBuilder: (dynamic item) {
                                        final companyName =
                                            (item as Company).company;
                                        return companyName;
                                      },
                                    ),
                                  ),
                                  /* EmployeeSelectionStatus(
                            onTap: (value) {
                              context
                                  .read<EmployeeBloc>()
                                  .add(EmployeeDetailEvent.selectStatus(value));
                            },
                          ),*/
                                ]),
                            CompanyDetailSection(settingsItems: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: MultiSelectDropdown(
                                  items: [].toList(),
                                  hint: 'Select department',
                                  onSelectedItemsChanged: (items) {
                                    context.read<EmployeeBloc>().add(
                                        EmployeeDetailEvent.selectDepartment(
                                            items));
                                  },
                                  isReadOnly: true,
                                  selectedItems: [widget.employee.department],
                                  itemNameBuilder: (dynamic item) {
                                    return item;
                                  },
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
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
                                  status: state.employeeStatus.toString(),
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
