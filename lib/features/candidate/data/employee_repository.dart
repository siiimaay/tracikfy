import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:trackify/features/candidate/data/employee.dart';

import '../../../../core/injection/locator.dart';

@injectable
class EmployeeRepository {
  static EmployeeRepository? _instance;
  late final FirestoreService _employeeStorageService;

  EmployeeRepository._() {
    _employeeStorageService = getIt.get(instanceName: "employee_firestore");
  }

  factory EmployeeRepository() {
    return _instance ??= EmployeeRepository._();
  }

  Future<List?> fetchEmployees() async {
    return await _employeeStorageService.fetchRecords();
  }

  Future<void> deleteEmployee(String? id) async {
    await _employeeStorageService.deleteRecord(id: id);
  }
  Future<void> updateEmployee(String? id, Employee updatedEmployee) async {
    await _employeeStorageService.updateRecord(id: id, data: updatedEmployee);
  }

  Future<void> saveEmployee({
    required Employee employee,
  }) async {
    await _employeeStorageService.saveRecord(data: employee);
  }

  Stream<List<Employee>> listenEmployee() {
    return _employeeStorageService.listenFetchRecords()
        as Stream<List<Employee>>;
  }
}
