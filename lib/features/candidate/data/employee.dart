import 'package:freezed_annotation/freezed_annotation.dart';

import 'employee_status.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String name;
  final String? userId;
  final String status;
  final List<dynamic> department;
  final String? companyId;

  Employee( {
    required this.name,
    required this.status,
    required this.department,
    required this.companyId,
    this.userId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
