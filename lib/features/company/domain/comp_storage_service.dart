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
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final company = Company(
      company: data.company,
      workArea: data.workArea,
      phoneNo: data.phoneNo,
      userId: userId,
    ).toJson();
    await _firebaseFirestore.collection('company').doc(id).set(company);
  }
}
