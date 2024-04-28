import 'package:freezed_annotation/freezed_annotation.dart';

import 'employee_status.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String name;
  final EmployeeStatus status;
  final List<String> department;
  final String companyId;

  Employee({
    required this.name,
    required this.status,
    required this.department,
    required this.companyId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
