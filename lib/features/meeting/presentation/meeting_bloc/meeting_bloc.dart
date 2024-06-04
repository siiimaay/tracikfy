import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/meeting.dart';
import 'meeting_event.dart';
import 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingLoadInProgress()) {

    on<LoadMeetings>(_onLoadMeetings);
    on<AddMeeting>(_onAddMeeting);
  }

  Future<void> _onLoadMeetings(LoadMeetings event, Emitter<MeetingState> emit) async {
    try {
      //await Future.delayed(Duration(seconds: 2));
      final meetings = [
        Meeting(
          time: '9:30 - 10:20',
          title: 'Pets App',
          description: 'UI screen Review',
          person: 'Simay Ekici',
          platform: 'Google Meet',
          color: Colors.purple,
        ),
        Meeting(
          time: '11:00 - 11:50',
          title: 'Fundr App',
          description: 'Review user flow',
          person: 'Simay',
          platform: '',
          color: Colors.lightBlue,
        ),
        Meeting(
          time: '12:20 - 13:00',
          title: 'Meeting with team',
          description: 'Innovatics website',
          person: 'Ui-Ux team',
          platform: '',
          color: Colors.lightGreen,
        ),
      ];
      emit(MeetingLoadSuccess(meetings));
    } catch (_) {
      emit(MeetingLoadFailure());
    }
  }

  Future<void> _onAddMeeting(AddMeeting event, Emitter<MeetingState> emit) async {
    if (state is MeetingLoadSuccess) {
      final List<Meeting> updatedMeetings = List.from((state as MeetingLoadSuccess).meetings)
        ..add(event.meeting);
      emit(MeetingLoadSuccess(updatedMeetings));
    }
  }
}
