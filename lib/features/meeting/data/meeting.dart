import 'dart:ui';

class Meeting {
  final String time;
  final String title;
  final String description;
  final String person;
  final String platform;
  final Color? color;

  Meeting({
    required this.time,
    required this.title,
    required this.description,
    required this.person,
    required this.platform,
    this.color,
  });
}
