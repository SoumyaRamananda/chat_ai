import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  /// Example: 10:45 PM
  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Example: Feb 22, 2026
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  static String formatChatTimestamp(DateTime dateTime) {
    final now = DateTime.now();

    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return formatTime(dateTime);
    } else if (difference == 1) {
      return "Yesterday";
    } else if (difference < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }
}
