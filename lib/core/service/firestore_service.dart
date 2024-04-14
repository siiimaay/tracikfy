
abstract class FirestoreService<T> {
  Future<void> saveRecord();

  Future<void> deleteRecord({String? id});

  Future<void> updateRecord();

  Future<List<T>> fetchRecords();
}
