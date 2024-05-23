import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/injection/locator.dart';
import '../bloc/employee_bloc.dart';
import '../data/employee_status.dart';
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
      listener: (context, state) {
        if (state.isLoading == true) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        final candidateList = state.employees
            .where(
                (element) => element.status == EmployeeStatus.interviewing.name)
            .toList();
        return ListView.builder(
            itemCount: widget.isCandidate
                ? candidateList.length
                : state.employees.length,
            itemBuilder: (context, index) {
              final employees = widget.isCandidate
                  ? state.employees
                      .where((element) =>
                          element.status == EmployeeStatus.interviewing.name)
                      .toList()
                  : state.employees;
              final employee = employees[index];

              return EmployeeDetailCard(
                name: employee.name,
                title: employee.department.first,
                department: employee.department.first,
                status: employee.status, companyId: employee.companyId,
              );
            });
      },
    );
  }
}
