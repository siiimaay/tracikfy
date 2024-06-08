import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/meeting/presentation/add_meeting_screen.dart';

import 'meeting_bloc/meeting_bloc.dart';
import 'meeting_bloc/meeting_event.dart';
import 'meeting_bloc/meeting_state.dart';

class MeetingView extends StatefulWidget {
  static const route = "/meeting_view";

  const MeetingView({super.key});

  @override
  MeetingViewState createState() => MeetingViewState();
}

class MeetingViewState extends State<MeetingView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
      ),
      body: BlocProvider(
        create: (context) => MeetingBloc()..add(LoadMeetings()),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xff9CA5D9)),
                  const SizedBox(width: 8),
                  Text(
                    '30 May - 2023',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.color.appThemeMainColor),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.color.appThemeMainColor.withOpacity(0.9),
                    ),
                    onPressed: () {
                      context.push(
                          "${MeetingView.route}/${AddMeetingScreen.route}");
                    },
                    child: const Text(
                      '+ Add Meeting',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: context.color.appThemeMainColor,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xff9CA5D9),
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<MeetingBloc, MeetingState>(
                builder: (context, state) {
                  if (state is MeetingLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MeetingLoadSuccess) {
                    final meetings = state.meetings;
                    return ListView.builder(
                      itemCount: meetings.length,
                      itemBuilder: (context, index) {
                        final meeting = meetings[index];
                        return MeetingCard(
                          time: meeting.time,
                          title: meeting.title,
                          description: meeting.description,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Failed to load meetings'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final bool isInMeetingPage;
  final int participantLength;

  const MeetingCard({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    this.isInMeetingPage = true,
    this.participantLength = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
          border: Border.all(
        color: const Color(0xff8d9cf1).withOpacity(0.3),
      )),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isInMeetingPage)
            Column(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xff8d9cf1),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey,
                ),
              ],
            ),
          const SizedBox(width: 8),
          SizedBox(
            width: 250,
            height: 190,
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(time,
                        style: TextStyle(
                          color: context.color.appThemeMainColor,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: context.color.appThemeMainColor)),
                    const SizedBox(height: 4),
                    if (description.isNotEmpty) Text(description),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Text("$participantLength"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.video_call, size: 16),
                        SizedBox(width: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
