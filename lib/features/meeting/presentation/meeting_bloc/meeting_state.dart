import 'package:equatable/equatable.dart';
import '../../data/interview.dart';
import '../../data/meeting.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object> get props => [];
}

class MeetingLoadInProgress extends MeetingState {}

class MeetingLoadSuccess extends MeetingState {
  final List<Interview> meetings;

  const MeetingLoadSuccess(this.meetings);

  @override
  List<Object> get props => [meetings];
}

class MeetingLoadFailure extends MeetingState {}
