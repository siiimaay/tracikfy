import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/injection/locator.dart';
import '../../../../core/service/firestore_service.dart';
import '../../data/interview.dart';
import '../../data/meeting.dart';
import 'meeting_event.dart';
import 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final FirestoreService _interviewStorageService =
  getIt.get(instanceName: "interview_firestore");

  MeetingBloc() : super(MeetingLoadInProgress()) {

    on<LoadMeetings>(_onLoadMeetings);
    //on<AddMeeting>(_onAddMeeting);
  }

  Future<void> _onLoadMeetings(LoadMeetings event, Emitter<MeetingState> emit) async {
    try {
      //await Future.delayed(Duration(seconds: 2));
      final interviews =
      await _interviewStorageService.fetchRecords() as List<Interview>;
      emit(MeetingLoadSuccess(interviews));
    } catch (_) {
      emit(MeetingLoadFailure());
    }
  }


}
