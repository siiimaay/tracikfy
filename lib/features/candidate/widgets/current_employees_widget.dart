import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/candidate/data/employee_repository.dart';
import 'package:trackify/features/company/data/company.dart';

import '../../../core/injection/locator.dart';
import '../bloc/employee_bloc.dart';
import '../data/employee.dart';
import '../data/employee_status.dart';
import 'candidate_evaluation.dart';
import 'employee_detail_card.dart';

class EmployeesView extends StatefulWidget {
  final bool isCandidate;

  const EmployeesView({
    super.key,
    this.isCandidate = false,
  });

  @override
  State<EmployeesView> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends State<EmployeesView> {
  @override
  void initState() {
    super.initState();
    context
        .read<EmployeeBloc>()
        .add(const EmployeeDetailEvent.fetchEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeDetailState>(
      listener: (c, s) {},
      builder: (context, state) {
        return StreamBuilder(
            stream: getIt.get<EmployeeRepository>().listenEmployee(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if ((snapshot.data!).isNotEmpty) {
                final employeeList = snapshot.data
                    ?.where((element) =>
                element.status == EmployeeStatus.active.name || element.status == EmployeeStatus.onboarding.name || element.status == "Deactivated")
                    .toList();
                final candidates = snapshot.data
                    ?.where((element) =>
                element.status == EmployeeStatus.interviewing.name)
                    .toList();
                final rejected = snapshot.data
                    ?.where((element) =>
                element.status == "Rejected")
                    .toList();

                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: context.color.settingsBackColor,
                  padding: const EdgeInsets.all(8.0),
                  child: widget.isCandidate
                      ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildExpandableSection(
                          context,
                          title: "Active Candidates",
                          employees: candidates,
                          state: state,
                          isCandidate: true,
                        ),
                        const SizedBox(height: 16.0),
                        _buildExpandableSection(
                          context,
                          title: "Rejected Employees",
                          employees: rejected,
                          state: state,
                          isCandidate: true,
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: employeeList?.length,
                    itemBuilder: (context, index) {
                      final employee = employeeList?[index];
                      return EmployeeDetailCard(
                        name: employee?.name ?? "Default",
                        title:
                        employee?.department.firstOrNull ?? "Default",
                        id: employee?.id,
                        department:
                        employee?.department.firstOrNull ?? "Default",
                        status: employee?.status ?? "Default",
                        company: employee?.company != null
                            ? Company.fromJson(employee!.company!)
                            : null,
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            });
      },
    );
  }

  Widget _buildExpandableSection(BuildContext context,
      {required String title,
        required List<Employee>? employees,
        required EmployeeDetailState state,
        required bool isCandidate}) {

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedShape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.color.appThemeMainColor),
        ),
        children: employees?.map((employee) {
          return Slidable(
            enabled: isCandidate,
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () async {
                context.read<EmployeeBloc>().add(
                    EmployeeDetailEvent.updateEmployee(Employee(
                        id: employee.id,
                        name: employee.name,
                        userId: employee.userId,
                        status: EmployeeStatus.rejected.name,
                        department: employee.department,
                        company: employee.company, title: employee.title)));
              }),
              children: [
                if (isCandidate && employee.status != "Rejected")
                  SlidableAction(
                    onPressed: (context) async {
                      context.read<EmployeeBloc>().add(
                          EmployeeDetailEvent.updateEmployee(Employee(
                              id: employee.id,
                              name: employee.name,
                              userId: employee.userId,
                              status: EmployeeStatus.rejected.name,
                              department: state.selectedDepartment,
                              company: state.selectedCompany?.toJson(), title: employee.title)));
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Mark as rejected',
                  ),
              ],
            ),
            child: EmployeeDetailCard(
              name: employee.name,
              title: employee.department.firstOrNull ?? "Default",
              id: employee.id,
              department: employee.department.firstOrNull ?? "Default",
              status: employee.status,
              userId: employee.userId,
              company: employee.company != null
                  ? Company.fromJson(employee.company!)
                  : null,
            ),
          );
        }).toList() ??
            [],
      ),
    );
  }
}
