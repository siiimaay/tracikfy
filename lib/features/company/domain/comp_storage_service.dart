import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

import '../data/company.dart';

@Named("company_firestore")
@Injectable(as: FirestoreService)
class CompanyStorageService implements FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('company');

  @override
  Future<void> deleteRecord({String? id}) async {
    try {
      await _collection.doc('$id').delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Company>>? fetchRecords() {
    List<Company> companies = [];

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          companies.add(Company.fromJson(data));
        }

        return companies;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> updateRecord({String? id, required dynamic data}) async {
    try {
      // Extract the id from the data object
      final documentId = (data as Company).id;

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
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final company = Company(
      id: id,
      company: data.company,
      workArea: data.workArea,
      phoneNo: data.phoneNo,
      userId: userId,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ).toJson();
    await _firebaseFirestore.collection('company').doc(id).set(company);
  }

  @override
  Stream<List<Company>>? listenFetchRecords() {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) {
        List<Company> companies = [];
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          companies.add(Company.fromJson(data));
        }
        return companies;
      });
    } catch (e) {
      return const Stream<List<Company>>.empty();
    }
  }
}
