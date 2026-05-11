import 'package:intl/intl.dart';

/// DateTime Extensions
/// Provides helpful methods for formatting and manipulating dates/times
extension DateTimeExtensions on DateTime {
  /// Check if this date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if this date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if this date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if this date is in the current week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekMidnight = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    final endOfWeek = startOfWeekMidnight.add(const Duration(days: 7));
    return isAfter(startOfWeekMidnight) && isBefore(endOfWeek);
  }

  /// Check if this date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if this date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Format as display date (e.g., "Monday, Jan 15, 2024")
  String get formatDisplayDate {
    return DateFormat('EEEE, MMM dd, yyyy').format(this);
  }

  /// Format as short date (e.g., "Jan 15, 2024")
  String get formatShortDate {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Format as time (e.g., "14:30")
  String get formatTime {
    return DateFormat('HH:mm').format(this);
  }

  /// Format as 12-hour time (e.g., "2:30 PM")
  String get formatTime12Hour {
    return DateFormat('h:mm a').format(this);
  }

  /// Format as date and time (e.g., "Jan 15, 2024 • 14:30")
  String get formatDateTime {
    return DateFormat('MMM dd, yyyy • HH:mm').format(this);
  }

  /// Format as date and time 12-hour (e.g., "Jan 15, 2024 • 2:30 PM")
  String get formatDateTime12Hour {
    return DateFormat('MMM dd, yyyy • h:mm a').format(this);
  }

  /// Get relative time description (e.g., "2 hours ago", "in 3 days")
  String get relativeTime {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) {
      // Past
      final absDifference = difference.abs();

      if (absDifference.inSeconds < 60) {
        return 'Just now';
      } else if (absDifference.inMinutes < 60) {
        final minutes = absDifference.inMinutes;
        return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
      } else if (absDifference.inHours < 24) {
        final hours = absDifference.inHours;
        return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
      } else if (absDifference.inDays < 7) {
        final days = absDifference.inDays;
        return '$days ${days == 1 ? 'day' : 'days'} ago';
      } else if (absDifference.inDays < 30) {
        final weeks = (absDifference.inDays / 7).floor();
        return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
      } else if (absDifference.inDays < 365) {
        final months = (absDifference.inDays / 30).floor();
        return '$months ${months == 1 ? 'month' : 'months'} ago';
      } else {
        final years = (absDifference.inDays / 365).floor();
        return '$years ${years == 1 ? 'year' : 'years'} ago';
      }
    } else {
      // Future
      if (difference.inSeconds < 60) {
        return 'In a moment';
      } else if (difference.inMinutes < 60) {
        final minutes = difference.inMinutes;
        return 'In $minutes ${minutes == 1 ? 'minute' : 'minutes'}';
      } else if (difference.inHours < 24) {
        final hours = difference.inHours;
        return 'In $hours ${hours == 1 ? 'hour' : 'hours'}';
      } else if (difference.inDays < 7) {
        final days = difference.inDays;
        return 'In $days ${days == 1 ? 'day' : 'days'}';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return 'In $weeks ${weeks == 1 ? 'week' : 'weeks'}';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return 'In $months ${months == 1 ? 'month' : 'months'}';
      } else {
        final years = (difference.inDays / 365).floor();
        return 'In $years ${years == 1 ? 'year' : 'years'}';
      }
    }
  }

  /// Get friendly date description (e.g., "Today", "Tomorrow", "Yesterday")
  String get friendlyDate {
    if (isToday) return 'Today';
    if (isTomorrow) return 'Tomorrow';
    if (isYesterday) return 'Yesterday';

    final now = DateTime.now();
    final difference = this.difference(now).inDays;

    if (difference > 0 && difference < 7) {
      return DateFormat('EEEE').format(this); // Day name
    }

    return formatShortDate;
  }

  /// Get time remaining as readable string (e.g., "2h 30m remaining")
  String get timeRemainingFormatted {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    }

    if (difference.inDays > 0) {
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      if (hours > 0) {
        return '${days}d ${hours}h remaining';
      }
      return '${days}d remaining';
    } else if (difference.inHours > 0) {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      if (minutes > 0) {
        return '${hours}h ${minutes}m remaining';
      }
      return '${hours}h remaining';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m remaining';
    } else {
      return 'Less than a minute';
    }
  }

  /// Get countdown text for cards (e.g., "2:30:15" for hours:minutes:seconds)
  String get countdownText {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get start of day (midnight)
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day (23:59:59)
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }

  /// Add months (handles edge cases)
  DateTime addMonths(int months) {
    int newYear = year;
    int newMonth = month + months;

    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }

    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }

    // Handle day overflow (e.g., Jan 31 + 1 month = Feb 28/29)
    int newDay = day;
    final daysInMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > daysInMonth) {
      newDay = daysInMonth;
    }

    return DateTime(newYear, newMonth, newDay, hour, minute, second);
  }

  /// Format for notification display
  String get notificationFormat {
    if (isToday) {
      return 'Today at ${formatTime12Hour}';
    } else if (isTomorrow) {
      return 'Tomorrow at ${formatTime12Hour}';
    } else {
      return formatDateTime12Hour;
    }
  }
}
