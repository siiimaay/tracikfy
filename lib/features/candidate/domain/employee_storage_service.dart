import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';
import 'package:uuid/uuid.dart';

import '../data/employee.dart';

@Named("employee_firestore")
@Injectable(as: FirestoreService)
class CompanyStorageService implements FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('employee');

  @override
  Future<void> deleteRecord({String? id}) async {
    try {
      await _collection.doc('$id').delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Employee>>? fetchRecords() {
    List<Employee> employees = [];

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          employees.add(Employee.fromJson(data));
        }

        return employees;
      });
    } catch (e) {}
    return null;
  }

  @override
  Future<void> updateRecord() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveRecord({required dynamic data}) async {
    final id = const Uuid().v4();
    final employeeData = (data as Employee);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final employee = Employee(
            userId: userId,
            name: employeeData.name,
            status: EmployeeStatus.active,
            department: employeeData.department,
            companyId: employeeData.companyId)
        .toJson();
    await _firebaseFirestore.collection('employee').doc(id).set(employee);
  }
}
