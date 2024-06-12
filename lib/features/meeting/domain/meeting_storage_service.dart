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
    List<Interview> interviews = [];
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    int startOfDayMillis = startOfDay.millisecondsSinceEpoch;
    int endOfDayMillis = endOfDay.millisecondsSinceEpoch;
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw 'User id must not be null';

      return _collection
          .where('userId', isEqualTo: userId)
          .where('time', isGreaterThanOrEqualTo: startOfDayMillis)
          .where('time', isLessThanOrEqualTo: endOfDayMillis)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          interviews.add(Interview.fromJson(data));
        }

        return interviews;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> updateRecord({String? id, required dynamic data}) {
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
      category: interviewData.category,
      desc: interviewData.desc,
      employees: (interviewData.employees).map((e) => e.toJson()).toList(),
      userId: userId,
    ).toJson();
    await _firebaseFirestore.collection('interviews').doc(id).set(interview);
  }

  @override
  Stream<List>? listenFetchRecords() {
    // TODO: implement listenFetchRecords
    throw UnimplementedError();
  }
}
