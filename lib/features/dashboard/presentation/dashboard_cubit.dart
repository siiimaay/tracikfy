import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/injection/locator.dart';
import '../../../core/service/firestore_service.dart';
import '../../candidate/data/employee.dart';
import '../../candidate/data/employee_repository.dart';
import '../../meeting/data/interview.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FirestoreService _interviewStorageService =
      getIt.get(instanceName: "interview_firestore");

  DashboardCubit() : super(const DashboardState()) {
    fetchInterviews();
    fetchTeamMembers();
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
  void fetchTeamMembers() async {
    final employees = await getIt.get<EmployeeRepository>().fetchEmployees() as List<Employee>;
    emit(state.copyWith(employees: (employees)));
  }
}
