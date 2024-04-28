
part of 'employee_bloc.dart';

@freezed
class EmployeeDetailEvent with _$EmployeeDetailEvent {
  const factory EmployeeDetailEvent.save(dynamic data) = _Save;
}