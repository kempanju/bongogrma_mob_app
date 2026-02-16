import 'package:timeago/timeago.dart' as timeago;

class TimeUtils {
  static String getTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return '${_monthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }

  static String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  static String getDaysAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 5) {
      return formatDate(dateTime);
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 23) {
      return '${difference.inDays} day ago';
    } else if (difference.inMinutes > 59) {
      return '${difference.inHours} hours ago';
    } else if (difference.inSeconds > 59) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'now';
    }
  }
}
