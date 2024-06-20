import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

import '../data/employee.dart';

@Named("employee_firestore")
@Injectable(as: FirestoreService)
class EmployeeStorageService implements FirestoreService {
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
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateRecord({String? id, required dynamic data}) async {
    try {
      // Extract the id from the data object
      final documentId = (data as Employee).id;

      // Query the collection to find the document with the matching id field
      QuerySnapshot querySnapshot =
          await _collection.where('id', isEqualTo: documentId).get();
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document with the matching id
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Update the document with the data converted to JSON
        await docRef.update(data.toJson());
        print('Document ID: ${docRef.id}');

        print('Document updated successfully');
      } else {
        print('No document found with the specified id.');
      }
    } catch (e) {
      // Print an error message if an exception occurs
      print('Error updating document: $e');
    }
  }

  @override
  Future<void> saveRecord({required dynamic data}) async {
    final id = const Uuid().v4();
    final employeeData = (data as Employee);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print(id);
    try {
      final employee = Employee(
        id: id,
        userId: userId,
        name: employeeData.name,
        status: employeeData.status,
        department: employeeData.department,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        company: employeeData.company,
        title: employeeData.title,
      ).toJson();
      await _firebaseFirestore.collection('employee').doc(id).set(employee);
    } catch (e) {
      print("error is here $e");
    }
  }

  @override
  Stream<List<Employee>>? listenFetchRecords() {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) {
        List<Employee> employees = [];
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          employees.add(Employee.fromJson(data));
        }
        print(employees.length);
        return employees;
      });
    } catch (e) {
      return const Stream<List<Employee>>.empty();
    }
  }
}
