part of 'employee_bloc.dart';

@freezed
class EmployeeDetailState with _$EmployeeDetailState {
  const factory EmployeeDetailState({
    bool? isLoading,
    @Default([]) List<dynamic> selectedDepartment,
    Company? selectedCompany,
    @Default("") employeeStatus,
    bool? isOperationSuccessful,
    @Default([]) List<Company> companies,
    @Default([]) List<Employee> employees,
  }) = _EmployeeDetailState;

  factory EmployeeDetailState.initial() {
    return const EmployeeDetailState();
  }
}
