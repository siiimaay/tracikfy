import 'package:freezed_annotation/freezed_annotation.dart';

import '../../company/data/company.dart';
import 'employee_status.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String? id;
  final String name;
  final String title;
  final String? userId;
  final String status;
  final List<dynamic> department;
  final Map<String, dynamic>? company;
  final int? createdAt;
  final bool isDeleted;

  Employee(  {
    required this.name,
    required this.status,
    required this.department,
    required this.company,
    this.userId,
    this.createdAt,
    this.id,
    this.isDeleted = false,
    required this.title,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
