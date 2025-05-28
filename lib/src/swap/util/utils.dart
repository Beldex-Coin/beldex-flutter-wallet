import 'package:intl/intl.dart';

String toStringAsFixed(String? amount) {
  final double d = double.parse(amount!);
  final String inString = d>=100000.00 ? d.toStringAsFixed(2): d.toStringAsFixed(9);
  return inString;
}

String getDate(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('dd MMM yyyy').format(date);
}

String getDateAndTime(int timeStamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timeStamp);
  return DateFormat('dd MMM yyyy, HH:mm:ss').format(date);
}

String truncateMiddle(String input, {int start = 3, int end = 3}) {
  if (input.length <= start + end) return input;
  return '${input.substring(0, start)}...${input.substring(input.length - end)}';
}