import 'package:injectable/injectable.dart';
import 'package:trackify/core/service/firestore_service.dart';

import '../../../../core/injection/locator.dart';
import '../interview.dart';

@injectable
class InterviewRepository {
  static InterviewRepository? _instance;
  late final FirestoreService _interviewStorageService;

  InterviewRepository._() {
    _interviewStorageService = getIt.get(instanceName: "interview_firestore");
  }

  factory InterviewRepository() {
    return _instance ??= InterviewRepository._();
  }

  Future<List?> fetchInterviews() async {
    return await _interviewStorageService.fetchRecords();
  }

  Future<void> deleteInterview(String id) async {
    await _interviewStorageService.deleteRecord(id: id);
  }

  Future<void> saveInterview({
    required Interview interview,
  }) async {
    await _interviewStorageService.saveRecord(data: interview);
  }
}
