import 'package:hive_flutter/hive_flutter.dart';
import 'package:coco/features/reminder/data/models/reminder_model.dart';
import 'package:coco/core/constants/app_constants.dart';

/// Reminder Local Data Source
/// Handles direct interaction with Hive database for reminder storage
/// Provides CRUD operations and filtering methods
class ReminderLocalDataSource {
  final Box<ReminderModel> _reminderBox;

  ReminderLocalDataSource(this._reminderBox);

  /// Initialize Hive and open reminder box
  static Future<ReminderLocalDataSource> initialize() async {
    await Hive.initFlutter();

    // Register adapter if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ReminderModelAdapter());
    }

    final box = await Hive.openBox<ReminderModel>(AppConstants.hiveBoxName);
    return ReminderLocalDataSource(box);
  }

  /// Get all reminders from local database
  List<ReminderModel> getAllReminders() {
    try {
      return _reminderBox.values.toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get all reminders: $e');
    }
  }

  /// Get a reminder by ID
  ReminderModel? getReminderById(String id) {
    try {
      return _reminderBox.values.firstWhere(
        (reminder) => reminder.id == id,
        orElse: () => throw ReminderNotFoundException(id),
      );
    } on ReminderNotFoundException {
      return null;
    } catch (e) {
      throw LocalDataSourceException('Failed to get reminder by ID: $e');
    }
  }

  /// Create a new reminder
  Future<void> createReminder(ReminderModel reminder) async {
    try {
      await _reminderBox.put(reminder.id, reminder);
    } catch (e) {
      throw LocalDataSourceException('Failed to create reminder: $e');
    }
  }

  /// Update an existing reminder
  Future<void> updateReminder(ReminderModel reminder) async {
    try {
      if (!_reminderBox.containsKey(reminder.id)) {
        throw ReminderNotFoundException(reminder.id);
      }
      await _reminderBox.put(reminder.id, reminder);
    } catch (e) {
      throw LocalDataSourceException('Failed to update reminder: $e');
    }
  }

  /// Delete a reminder by ID
  Future<void> deleteReminder(String id) async {
    try {
      if (!_reminderBox.containsKey(id)) {
        throw ReminderNotFoundException(id);
      }
      await _reminderBox.delete(id);
    } catch (e) {
      throw LocalDataSourceException('Failed to delete reminder: $e');
    }
  }

  /// Get reminders by status (using enum index)
  List<ReminderModel> getRemindersByStatus(int statusIndex) {
    try {
      return _reminderBox.values
          .where((reminder) => reminder.status == statusIndex)
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get reminders by status: $e');
    }
  }

  /// Get today's reminders
  List<ReminderModel> getTodayReminders() {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));

      return _reminderBox.values
          .where(
            (reminder) =>
                reminder.dateTime.isAfter(today) &&
                reminder.dateTime.isBefore(tomorrow),
          )
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get today reminders: $e');
    }
  }

  /// Get this week's reminders
  List<ReminderModel> getWeekReminders() {
    try {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final startOfWeekMidnight = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day,
      );
      final endOfWeek = startOfWeekMidnight.add(const Duration(days: 7));

      return _reminderBox.values
          .where(
            (reminder) =>
                reminder.dateTime.isAfter(startOfWeekMidnight) &&
                reminder.dateTime.isBefore(endOfWeek),
          )
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get week reminders: $e');
    }
  }

  /// Get completed reminders
  List<ReminderModel> getCompletedReminders() {
    try {
      // Status.completed index is 1
      return getRemindersByStatus(1);
    } catch (e) {
      throw LocalDataSourceException('Failed to get completed reminders: $e');
    }
  }

  /// Get active (pending) reminders
  List<ReminderModel> getActiveReminders() {
    try {
      // Status.pending index is 0
      return getRemindersByStatus(0);
    } catch (e) {
      throw LocalDataSourceException('Failed to get active reminders: $e');
    }
  }

  /// Get overdue reminders
  List<ReminderModel> getOverdueReminders() {
    try {
      final now = DateTime.now();
      return _reminderBox.values
          .where(
            (reminder) =>
                reminder.status == 0 && // pending status
                reminder.dateTime.isBefore(now),
          )
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get overdue reminders: $e');
    }
  }

  /// Get reminders by category
  List<ReminderModel> getRemindersByCategory(int categoryIndex) {
    try {
      return _reminderBox.values
          .where((reminder) => reminder.category == categoryIndex)
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get reminders by category: $e');
    }
  }

  /// Get reminders by priority
  List<ReminderModel> getRemindersByPriority(int priorityIndex) {
    try {
      return _reminderBox.values
          .where((reminder) => reminder.priority == priorityIndex)
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to get reminders by priority: $e');
    }
  }

  /// Search reminders by query (title or description)
  List<ReminderModel> searchReminders(String query) {
    try {
      if (query.isEmpty) return getAllReminders();

      final lowerQuery = query.toLowerCase();
      return _reminderBox.values
          .where(
            (reminder) =>
                reminder.title.toLowerCase().contains(lowerQuery) ||
                reminder.description.toLowerCase().contains(lowerQuery),
          )
          .toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to search reminders: $e');
    }
  }

  /// Get count of reminders by status
  int getRemindersCountByStatus(int statusIndex) {
    try {
      return _reminderBox.values
          .where((reminder) => reminder.status == statusIndex)
          .length;
    } catch (e) {
      throw LocalDataSourceException(
        'Failed to get reminders count by status: $e',
      );
    }
  }

  /// Get total count of all reminders
  int getTotalRemindersCount() {
    try {
      return _reminderBox.length;
    } catch (e) {
      throw LocalDataSourceException('Failed to get total reminders count: $e');
    }
  }

  /// Delete all completed reminders
  Future<void> deleteCompletedReminders() async {
    try {
      final completedReminders = getCompletedReminders();
      for (final reminder in completedReminders) {
        await _reminderBox.delete(reminder.id);
      }
    } catch (e) {
      throw LocalDataSourceException(
        'Failed to delete completed reminders: $e',
      );
    }
  }

  /// Delete all reminders (use with caution)
  Future<void> deleteAllReminders() async {
    try {
      await _reminderBox.clear();
    } catch (e) {
      throw LocalDataSourceException('Failed to delete all reminders: $e');
    }
  }

  /// Watch all reminders (stream for real-time updates)
  Stream<List<ReminderModel>> watchAllReminders() {
    try {
      return _reminderBox.watch().map((_) => getAllReminders());
    } catch (e) {
      throw LocalDataSourceException('Failed to watch all reminders: $e');
    }
  }

  /// Watch reminders by status (stream for real-time updates)
  Stream<List<ReminderModel>> watchRemindersByStatus(int statusIndex) {
    try {
      return _reminderBox.watch().map((_) => getRemindersByStatus(statusIndex));
    } catch (e) {
      throw LocalDataSourceException('Failed to watch reminders by status: $e');
    }
  }

  /// Backup reminders to JSON
  List<Map<String, dynamic>> backupToJson() {
    try {
      return _reminderBox.values.map((reminder) => reminder.toJson()).toList();
    } catch (e) {
      throw LocalDataSourceException('Failed to backup reminders: $e');
    }
  }

  /// Restore reminders from JSON
  Future<void> restoreFromJson(List<Map<String, dynamic>> jsonList) async {
    try {
      await _reminderBox.clear();
      for (final json in jsonList) {
        final reminder = ReminderModel.fromJson(json);
        await _reminderBox.put(reminder.id, reminder);
      }
    } catch (e) {
      throw LocalDataSourceException('Failed to restore reminders: $e');
    }
  }

  /// Close the Hive box
  Future<void> close() async {
    try {
      await _reminderBox.close();
    } catch (e) {
      throw LocalDataSourceException('Failed to close database: $e');
    }
  }

  /// Compact the database (optimization)
  Future<void> compactDatabase() async {
    try {
      await _reminderBox.compact();
    } catch (e) {
      throw LocalDataSourceException('Failed to compact database: $e');
    }
  }
}

/// Custom Exceptions

/// Exception thrown when a local data source operation fails
class LocalDataSourceException implements Exception {
  final String message;
  LocalDataSourceException(this.message);

  @override
  String toString() => 'LocalDataSourceException: $message';
}

/// Exception thrown when a reminder is not found
class ReminderNotFoundException implements Exception {
  final String reminderId;
  ReminderNotFoundException(this.reminderId);

  @override
  String toString() =>
      'ReminderNotFoundException: Reminder with ID $reminderId not found';
}
