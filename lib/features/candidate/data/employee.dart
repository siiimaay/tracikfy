import 'package:freezed_annotation/freezed_annotation.dart';

import '../../company/data/company.dart';
import 'employee_status.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String? id;
  final String name;
  final String? userId;
  final String status;
  final List<dynamic> department;
  final Map<String, dynamic>? company;
  final int? createdAt;

  Employee({
    required this.name,
    required this.status,
    required this.department,
    required this.company,
    this.userId,
    this.createdAt,
    this.id,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
