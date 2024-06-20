import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'candidate_evaluation.dart';
import 'confirm_dialog.dart';

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
  final ScrollController _scrollController = ScrollController();

  final FocusNode _employeeNameFocusNode = FocusNode();
  final FocusNode _workAreaFocusNode = FocusNode();
  final FocusNode _contactInfoFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    employeeNameController.text = widget.employee.name;
    workAreaController.text = widget.employee.title;
    contactInfoController.text = widget.employee.department;
  }

  @override
  void dispose() {
    employeeNameController.dispose();
    workAreaController.dispose();
    contactInfoController.dispose();
    _scrollController.dispose();
    _employeeNameFocusNode.dispose();
    _workAreaFocusNode.dispose();
    _contactInfoFocusNode.dispose();
    super.dispose();
  }

  void _scrollToFocusNode(FocusNode focusNode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (focusNode.context != null) {
        _scrollController.animateTo(
          _scrollController.position.pixels + focusNode.offset.dy,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (ctx) => EmployeeBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: context.color.settingsBackColor,
          appBar: AppBar(
            title: const Text("Employee Details"),
            surfaceTintColor: Colors.white,
            backgroundColor: context.color.settingsBackColor,
            actions: [
              PopupMenuButton<String>(
                color: context.color.settingsBackColor,
                surfaceTintColor: context.color.settingsBackColor,
                elevation: 5,
                offset: const Offset(45, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: context.color.settingsItemShadow)),
                onSelected: (String result) {
                  switch (result) {
                    case 'Deactivate':
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return ConfirmationDialog(
                                title: "You are about to deactivate employee",
                                content: "This action cannot be undone!",
                                onConfirm: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(result);
                                  context.read<EmployeeBloc>().add(
                                      EmployeeDetailEvent.updateEmployee(
                                          Employee(
                                              id: widget.employee.id,
                                              name: employeeNameController.text,
                                              status:
                                                  EmployeeStatus
                                                      .deactivated.name
                                                      .toString(),
                                              isDeleted: true,
                                              userId:
                                                  widget
                                                      .employee.company?.userId,
                                              department: [
                                                widget.employee.department
                                              ],
                                              title: workAreaController.text,
                                              company: widget.employee.company
                                                  ?.toJson())));
                                },
                                onCancel: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(result);
                                },
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)));
                          });

                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Deactivate',
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: Text(
                        'Deactivate Employee',
                        style:
                            TextStyle(color: context.color.appThemeMainColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                BlocBuilder<EmployeeBloc, EmployeeDetailState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: bottomInset > 0 ? bottomInset : 80.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      widget.employee.name,
                                      style: context.textStyle.detailText
                                          .copyWith(
                                              color: context
                                                  .color.appThemeMainColor,
                                              fontSize: 20),
                                    ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: context
                                                .color.appThemeMainColor),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            enableDrag: true,
                                            useSafeArea: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.0)),
                                            builder: (context) => Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    0.4,
                                                child: LoadingModal()),
                                          );
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.show_chart_rounded,
                                                color: Colors.white),
                                            SizedBox(width: 16),
                                            Text(
                                              'Evaluate Candidate',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
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
                                    text: "Title",
                                    valueText: widget.employee.title,
                                    prefixIcon: Icon(
                                      Icons.account_balance_outlined,
                                      color: const Color(0xff09093b)
                                          .withOpacity(0.7),
                                    ),
                                    textEditingController: workAreaController,
                                    focusNode: _employeeNameFocusNode,
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
                                      selectedItem: [
                                        state.companies
                                            .where((comp) =>
                                                comp.id ==
                                                widget.employee.company?.id)
                                            .firstOrNull
                                      ].first,
                                      onLoad: () => context
                                          .read<EmployeeBloc>()
                                          .add(const EmployeeDetailEvent
                                              .fetchCompanies()),
                                      itemNameBuilder: (dynamic item) {
                                        final companyName =
                                            (item as Company?)?.company ??
                                                "Default";
                                        return companyName;
                                      },
                                    ),
                                  ),
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
                  },
                ),
                BlocBuilder<EmployeeBloc, EmployeeDetailState>(
                  builder: (context, state) {
                    print("byra mı${state.employeeStatus}");
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SubmitButton(
                          buttonText: 'Update',
                          onPressed: () {
                            context.read<EmployeeBloc>().add(EmployeeDetailEvent.selectStatus(widget.employee.status));
                            context.read<EmployeeBloc>().add(
                                EmployeeDetailEvent.updateEmployee(Employee(
                                    id: widget.employee.id,
                                    name: employeeNameController.text,
                                    status: state.employeeStatus ?? widget.employee.status,
                                    department: state.selectedDepartment,
                                    userId:  widget
                                        .employee.company?.userId,
                                    company: widget
                                        .employee.company?.toJson(),
                                    title: workAreaController.text)));
                          },
                          color: const Color(0xff09093b),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
