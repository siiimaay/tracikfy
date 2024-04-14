

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/service/firestore_service.dart';
import '../data/company.dart';

class CompanyStorageService implements FirestoreService {
  //final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
  Future<List<Company>> fetchRecords() {
    List companies = [];
    //final userId = FirebaseAuth.instance.currentUser?.uid;
    /*if (userId == null) throw 'User id must not be null';

    return _collection
        .where('userId', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        stopwatches.add(StopwatchRecord.fromJson(data));
      }*/

      //return stopwatches;
    throw UnimplementedError();

  }

  @override
  Future<void> updateRecord() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveRecord({
    String? name = 'Default',
    String? duration = '',
    List<String>? laps,
  }) async {
   /* final id = const Uuid().v4();
    final stopwatchRecords = StopwatchRecord(
      id: id,
      name: name!,
      duration: duration!,
      userId: FirebaseAuth.instance.currentUser!.uid,
      laps: laps ?? [],
    ).toJson();
    await _firebaseFirestore
        .collection('stopwatchRecords')
        .doc(id)
        .set(stopwatchRecords);*/
  }

}
