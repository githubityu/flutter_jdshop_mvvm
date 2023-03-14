import 'package:intl/intl.dart';

const MMDDHHMM = 'yyyy-MM-dd HH:mm';
const MMDDHHMMSS = 'yyyy-MM-dd HH:mm:ss';
const YYMMDD = 'yyyy-MM-dd';
const MMDD = 'MM-dd';


extension DateTimeExt on DateTime {
  String format([String newPattern='yyyy.MM.dd']) {
    return DateFormat(newPattern).format(this);
  }
  bool isSameDay(DateTime date,[String newPattern='yyyy-MM-dd']) {
    // ignore hour,minute,second..
    final dateFormat = DateFormat(newPattern);
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }

  bool isSameMM(DateTime date,[String newPattern='yyyy-MM-dd HH:mm']) {
    // ignore hour,minute,second..
    final dateFormat = DateFormat(newPattern);
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }

  String formatYYYYMMdd([String newPattern='dd/MM/yyyy']) {
    return DateFormat(newPattern).format(this);
  }
}
