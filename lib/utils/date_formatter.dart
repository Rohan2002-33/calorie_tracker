/// Small helper to format dates without extra packages.
class DateFormatter {
  DateFormatter._();

  static const List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// Example: Tuesday, 3 November 2026
  static String fullDate(DateTime date) {
    return '${_weekdays[date.weekday - 1]}, ${date.day} '
        '${_months[date.month - 1]} ${date.year}';
  }

  /// Example: 9:41 PM
  static String time(DateTime date) {
    final int hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final String minute = date.minute.toString().padLeft(2, '0');
    final String period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }
}
