

abstract class FirestoreService<T> {
  Future<void> saveRecord({required T data});

  Future<void> deleteRecord({String? id});

  Future<void> updateRecord({String? id, required T data});

  Future<List<T>>? fetchRecords();

  Stream<List<T>>? listenFetchRecords();
}
