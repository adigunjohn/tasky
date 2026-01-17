import 'package:intl/intl.dart';

String formatTimeStamp(DateTime timestamp) {
  final dateTime = timestamp.toLocal();
  final dateFormat = DateFormat("MMM d, y");
  final timeFormat = DateFormat("h:mm a");
  return "${dateFormat.format(dateTime)} | ${timeFormat.format(dateTime)}";
}


