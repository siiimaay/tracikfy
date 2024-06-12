import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/injection/locator.dart';
import '../../../core/service/firestore_service.dart';
import '../../meeting/data/interview.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FirestoreService _interviewStorageService =
      getIt.get(instanceName: "interview_firestore");

  DashboardCubit() : super(const DashboardState()) {
    fetchInterviews();
  }

  void updateSelection(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void fetchInterviews() async {
    final interviews =
        await _interviewStorageService.fetchRecords() as List<Interview>;
    if(!isClosed){
      emit(state.copyWith(interviews: interviews));

    }
  }
}
