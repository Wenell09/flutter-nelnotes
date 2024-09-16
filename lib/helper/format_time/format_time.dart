import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  DateTime localTime = dateTime.toLocal();
  return DateFormat("d MMMM, y HH:mm").format(localTime);
}
