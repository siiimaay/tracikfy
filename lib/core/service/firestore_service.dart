
import '../../features/company/data/company.dart';

abstract class FirestoreService<T> {
  Future<void> saveRecord({required T data});

  Future<void> deleteRecord({String? id});

  Future<void> updateRecord();

  Future<List<T>> fetchRecords();
}
