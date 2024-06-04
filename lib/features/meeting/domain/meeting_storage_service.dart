import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:trackify/features/meeting/data/interview.dart';
import 'package:uuid/uuid.dart';

@Named("interview_firestore")
@Injectable(as: FirestoreService)
class MeetingStorageService implements FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _collection = FirebaseFirestore.instance.collection('interviews');

  @override
  Future<void> deleteRecord({String? id}) async {
    try {
      await _collection.doc('$id').delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Interview>>? fetchRecords() {
    List<Interview> employees = [];

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          employees.add(Interview.fromJson(data));
        }

        return employees;
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateRecord() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveRecord({required dynamic data}) async {
    final id = const Uuid().v4();
    final interviewData = (data as Interview);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final interview = Interview(
      title: interviewData.title,
      time: interviewData.time,
      employees: interviewData.employees,
      userId: userId,
    ).toJson();
    await _firebaseFirestore.collection('interviews').doc(id).set(interview);
  }
}
