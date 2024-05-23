
import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final String person;
  final String platform;
  final Color color;

  MeetingCard({
    required this.time,
    required this.title,
    required this.description,
    required this.person,
    required this.platform,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: color.withOpacity(0.1),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(person),
            Text(platform),
          ],
        ),
        trailing: Text(time, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
