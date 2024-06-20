import '../../company/data/company.dart';

class EmployeeData {
  final String name;
  final String status;
  final String department;
  final Company? company;
  final String? id;
  final String? userId;
  final String title;


  const EmployeeData( {
    required this.name,
    required this.status,
    required this.company,
    required this.department,
    this.id,
    this.userId,
    required this.title,
  });
}
