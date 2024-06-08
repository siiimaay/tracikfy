import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatTime() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }
}
