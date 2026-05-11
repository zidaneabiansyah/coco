import 'package:equatable/equatable.dart';

/// Reminder Entity (Domain Model)
/// Represents the core business model for a reminder
/// Framework-independent and contains only business logic
class ReminderEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String? location;
  final ReminderCategory category;
  final ReminderPriority priority;
  final ReminderRepeat repeat;
  final ReminderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isNotificationEnabled;
  final List<String>? tags;

  const ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.location,
    required this.category,
    required this.priority,
    required this.repeat,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.isNotificationEnabled = true,
    this.tags,
  });

  /// Check if reminder is overdue
  bool get isOverdue {
    if (status == ReminderStatus.completed ||
        status == ReminderStatus.cancelled) {
      return false;
    }
    return DateTime.now().isAfter(dateTime);
  }

  /// Check if reminder is today
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if reminder is this week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return dateTime.isAfter(startOfWeek) && dateTime.isBefore(endOfWeek);
  }

  /// Get time remaining until reminder
  Duration get timeRemaining {
    return dateTime.difference(DateTime.now());
  }

  /// Check if reminder is active (not completed or cancelled)
  bool get isActive {
    return status == ReminderStatus.pending;
  }

  /// Copy with method for immutability
  ReminderEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    ReminderCategory? category,
    ReminderPriority? priority,
    ReminderRepeat? repeat,
    ReminderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isNotificationEnabled,
    List<String>? tags,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    dateTime,
    location,
    category,
    priority,
    repeat,
    status,
    createdAt,
    updatedAt,
    isNotificationEnabled,
    tags,
  ];

  @override
  bool get stringify => true;
}

/// Reminder Category Enum
enum ReminderCategory {
  work,
  personal,
  health,
  study,
  other;

  String get displayName {
    switch (this) {
      case ReminderCategory.work:
        return 'Work';
      case ReminderCategory.personal:
        return 'Personal';
      case ReminderCategory.health:
        return 'Health';
      case ReminderCategory.study:
        return 'Study';
      case ReminderCategory.other:
        return 'Other';
    }
  }
}

/// Reminder Priority Enum
enum ReminderPriority {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case ReminderPriority.low:
        return 'Low';
      case ReminderPriority.medium:
        return 'Medium';
      case ReminderPriority.high:
        return 'High';
    }
  }
}

/// Reminder Repeat Enum
enum ReminderRepeat {
  none,
  daily,
  weekly,
  monthly,
  yearly;

  String get displayName {
    switch (this) {
      case ReminderRepeat.none:
        return 'None';
      case ReminderRepeat.daily:
        return 'Daily';
      case ReminderRepeat.weekly:
        return 'Weekly';
      case ReminderRepeat.monthly:
        return 'Monthly';
      case ReminderRepeat.yearly:
        return 'Yearly';
    }
  }
}

/// Reminder Status Enum
enum ReminderStatus {
  pending,
  completed,
  cancelled,
  overdue;

  String get displayName {
    switch (this) {
      case ReminderStatus.pending:
        return 'Pending';
      case ReminderStatus.completed:
        return 'Completed';
      case ReminderStatus.cancelled:
        return 'Cancelled';
      case ReminderStatus.overdue:
        return 'Overdue';
    }
  }
}
