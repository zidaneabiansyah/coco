import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';

/// Reminder Repository Interface (Domain Layer)
/// Defines the contract for reminder data operations
/// Implementation will be in the data layer
abstract class ReminderRepository {
  /// Get all reminders
  Future<List<ReminderEntity>> getAllReminders();

  /// Get a reminder by ID
  Future<ReminderEntity?> getReminderById(String id);

  /// Create a new reminder
  Future<void> createReminder(ReminderEntity reminder);

  /// Update an existing reminder
  Future<void> updateReminder(ReminderEntity reminder);

  /// Delete a reminder
  Future<void> deleteReminder(String id);

  /// Mark reminder as completed
  Future<void> markAsCompleted(String id);

  /// Mark reminder as cancelled
  Future<void> markAsCancelled(String id);

  /// Get reminders by status
  Future<List<ReminderEntity>> getRemindersByStatus(ReminderStatus status);

  /// Get reminders for today
  Future<List<ReminderEntity>> getTodayReminders();

  /// Get reminders for this week
  Future<List<ReminderEntity>> getWeekReminders();

  /// Get completed reminders
  Future<List<ReminderEntity>> getCompletedReminders();

  /// Get active (pending) reminders
  Future<List<ReminderEntity>> getActiveReminders();

  /// Get overdue reminders
  Future<List<ReminderEntity>> getOverdueReminders();

  /// Get reminders by category
  Future<List<ReminderEntity>> getRemindersByCategory(
    ReminderCategory category,
  );

  /// Get reminders by priority
  Future<List<ReminderEntity>> getRemindersByPriority(
    ReminderPriority priority,
  );

  /// Search reminders by title or description
  Future<List<ReminderEntity>> searchReminders(String query);

  /// Get reminders count by status
  Future<int> getRemindersCountByStatus(ReminderStatus status);

  /// Get total reminders count
  Future<int> getTotalRemindersCount();

  /// Delete all completed reminders
  Future<void> deleteCompletedReminders();

  /// Delete all reminders (use with caution)
  Future<void> deleteAllReminders();

  /// Stream of all reminders (for real-time updates)
  Stream<List<ReminderEntity>> watchAllReminders();

  /// Stream of reminders by filter
  Stream<List<ReminderEntity>> watchRemindersByStatus(ReminderStatus status);
}
