
part of 'employee_bloc.dart';

@freezed
class EmployeeDetailEvent with _$EmployeeDetailEvent {
  const factory EmployeeDetailEvent.save(dynamic data) = _Save;
  const factory EmployeeDetailEvent.fetchCompanies() = _Fetch;
  const factory EmployeeDetailEvent.selectCompany(Company company) = _SelectCompany;
  const factory EmployeeDetailEvent.selectDepartment(List<dynamic> department) = _SelectDepartment;
  const factory EmployeeDetailEvent.selectStatus(String status) = _SelectStatus;



}