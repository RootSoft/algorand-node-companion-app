import 'package:intl/intl.dart';

String formatDate(DateTime dateTime, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(dateTime);
}

int differenceInRounds(DateTime dateTime) {
  final seconds = dateTime.difference(DateTime.now()).inSeconds;
  return (seconds / 4.5).round().abs();
}

int differenceInDays(DateTime dateTime) {
  return dateTime.difference(DateTime.now()).inDays;
}

extension DateTimeExtension on DateTime {
  String format({String pattern = 'dd/MM/yyyy'}) {
    return formatDate(this, pattern: pattern);
  }
}
