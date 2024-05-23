import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widgets/meeting_card.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  MeetingScreenState createState() => MeetingScreenState();
}

class MeetingScreenState extends State<MeetingScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MeetingCard(
                  time: '9:30 - 10:20',
                  title: 'Pets App',
                  description: 'UI screen Review',
                  person: 'Mohamed Ahmed',
                  platform: 'Google Meet',
                  color: Colors.purple,
                ),
                MeetingCard(
                  time: '11:00 - 11:50',
                  title: 'Fundr App',
                  description: 'Review user flow',
                  person: 'Shahenda Sherif',
                  platform: 'Zoom',
                  color: Colors.lightBlue,
                ),
                MeetingCard(
                  time: '12:20 - 13:00',
                  title: 'Meeting with team',
                  description: 'Innovatics website',
                  person: 'Ui-Ux team',
                  platform: 'Meeting room',
                  color: Colors.lightGreen,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add meeting screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
