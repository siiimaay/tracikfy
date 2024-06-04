import 'package:equatable/equatable.dart';
import '../../data/meeting.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class LoadMeetings extends MeetingEvent {}

class AddMeeting extends MeetingEvent {
  final Meeting meeting;

  const AddMeeting(this.meeting);

  @override
  List<Object> get props => [meeting];
}
