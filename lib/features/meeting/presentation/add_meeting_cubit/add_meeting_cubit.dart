import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:trackify/core/injection/locator.dart';
import 'package:trackify/features/meeting/data/interview.dart';
import '../../../../core/service/firestore_service.dart';
import '../../../candidate/data/employee_repository.dart';
import 'add_meeting_state.dart';

class AddMeetingCubit extends Cubit<AddMeetingState> {
  final FirestoreService _interviewStorageService =
      getIt.get(instanceName: "interview_firestore");

  AddMeetingCubit()
      : super(AddMeetingState(
          selectedDate: DateTime.now(),
          selectedTime: const TimeOfDay(hour: 9, minute: 30),
          title: '',
          description: '',
          categories: const ['Online', 'In-office'],
          members: const [
            {'name': 'Adham', 'role': 'Flutter'},
            {'name': 'Sarah', 'role': 'Ui-Ux'},
          ],
        )) {
    fetchTeamMembers();
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void fetchTeamMembers() async {
    final employees = await getIt.get<EmployeeRepository>().fetchEmployees();
    print(employees?.length);
    emit(state.copyWith(employees: (employees)));
  }

  void updateTime(TimeOfDay time) {
    emit(state.copyWith(
        selectedDate:
            state.selectedDate.copyWith(hour: time.hour, minute: time.minute)));
    print(state.selectedDate);
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateEmployees(List<dynamic> employees) {
    emit(state.copyWith(selectedEmployees: employees));
  }

  void updateCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void saveMeeting() {
    _interviewStorageService.saveRecord(
        data: Interview(
      title: state.title,
      time: state.selectedDate.millisecondsSinceEpoch,
      category: state.selectedCategory,
      employees: state.selectedEmployees,
      desc: state.description,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));
  }
}
