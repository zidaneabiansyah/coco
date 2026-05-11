import 'package:coco/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:coco/features/reminder/data/models/reminder_model.dart';
import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';
import 'package:coco/features/reminder/domain/repositories/reminder_repository.dart';

/// Reminder Repository Implementation
/// Implements the repository interface defined in domain layer
/// Acts as a bridge between data sources and business logic
class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource _localDataSource;

  ReminderRepositoryImpl(this._localDataSource);

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    try {
      final models = _localDataSource.getAllReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get all reminders: $e');
    }
  }

  @override
  Future<ReminderEntity?> getReminderById(String id) async {
    try {
      final model = _localDataSource.getReminderById(id);
      return model?.toEntity();
    } catch (e) {
      throw RepositoryException('Failed to get reminder by ID: $e');
    }
  }

  @override
  Future<void> createReminder(ReminderEntity reminder) async {
    try {
      final model = ReminderModel.fromEntity(reminder);
      await _localDataSource.createReminder(model);
    } catch (e) {
      throw RepositoryException('Failed to create reminder: $e');
    }
  }

  @override
  Future<void> updateReminder(ReminderEntity reminder) async {
    try {
      final model = ReminderModel.fromEntity(reminder);
      await _localDataSource.updateReminder(model);
    } catch (e) {
      throw RepositoryException('Failed to update reminder: $e');
    }
  }

  @override
  Future<void> deleteReminder(String id) async {
    try {
      await _localDataSource.deleteReminder(id);
    } catch (e) {
      throw RepositoryException('Failed to delete reminder: $e');
    }
  }

  @override
  Future<void> markAsCompleted(String id) async {
    try {
      final reminder = await getReminderById(id);
      if (reminder == null) {
        throw ReminderNotFoundException(id);
      }

      final updatedReminder = reminder.copyWith(
        status: ReminderStatus.completed,
        updatedAt: DateTime.now(),
      );

      await updateReminder(updatedReminder);
    } catch (e) {
      throw RepositoryException('Failed to mark reminder as completed: $e');
    }
  }

  @override
  Future<void> markAsCancelled(String id) async {
    try {
      final reminder = await getReminderById(id);
      if (reminder == null) {
        throw ReminderNotFoundException(id);
      }

      final updatedReminder = reminder.copyWith(
        status: ReminderStatus.cancelled,
        updatedAt: DateTime.now(),
      );

      await updateReminder(updatedReminder);
    } catch (e) {
      throw RepositoryException('Failed to mark reminder as cancelled: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getRemindersByStatus(
    ReminderStatus status,
  ) async {
    try {
      final models = _localDataSource.getRemindersByStatus(status.index);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get reminders by status: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getTodayReminders() async {
    try {
      final models = _localDataSource.getTodayReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get today reminders: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getWeekReminders() async {
    try {
      final models = _localDataSource.getWeekReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get week reminders: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getCompletedReminders() async {
    try {
      final models = _localDataSource.getCompletedReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get completed reminders: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getActiveReminders() async {
    try {
      final models = _localDataSource.getActiveReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get active reminders: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getOverdueReminders() async {
    try {
      final models = _localDataSource.getOverdueReminders();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get overdue reminders: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getRemindersByCategory(
    ReminderCategory category,
  ) async {
    try {
      final models = _localDataSource.getRemindersByCategory(category.index);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get reminders by category: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> getRemindersByPriority(
    ReminderPriority priority,
  ) async {
    try {
      final models = _localDataSource.getRemindersByPriority(priority.index);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to get reminders by priority: $e');
    }
  }

  @override
  Future<List<ReminderEntity>> searchReminders(String query) async {
    try {
      final models = _localDataSource.searchReminders(query);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw RepositoryException('Failed to search reminders: $e');
    }
  }

  @override
  Future<int> getRemindersCountByStatus(ReminderStatus status) async {
    try {
      return _localDataSource.getRemindersCountByStatus(status.index);
    } catch (e) {
      throw RepositoryException('Failed to get reminders count by status: $e');
    }
  }

  @override
  Future<int> getTotalRemindersCount() async {
    try {
      return _localDataSource.getTotalRemindersCount();
    } catch (e) {
      throw RepositoryException('Failed to get total reminders count: $e');
    }
  }

  @override
  Future<void> deleteCompletedReminders() async {
    try {
      await _localDataSource.deleteCompletedReminders();
    } catch (e) {
      throw RepositoryException('Failed to delete completed reminders: $e');
    }
  }

  @override
  Future<void> deleteAllReminders() async {
    try {
      await _localDataSource.deleteAllReminders();
    } catch (e) {
      throw RepositoryException('Failed to delete all reminders: $e');
    }
  }

  @override
  Stream<List<ReminderEntity>> watchAllReminders() {
    try {
      return _localDataSource.watchAllReminders().map(
        (models) => models.map((model) => model.toEntity()).toList(),
      );
    } catch (e) {
      throw RepositoryException('Failed to watch all reminders: $e');
    }
  }

  @override
  Stream<List<ReminderEntity>> watchRemindersByStatus(ReminderStatus status) {
    try {
      return _localDataSource
          .watchRemindersByStatus(status.index)
          .map((models) => models.map((model) => model.toEntity()).toList());
    } catch (e) {
      throw RepositoryException('Failed to watch reminders by status: $e');
    }
  }

  /// Additional utility methods

  /// Backup all reminders to JSON format
  Future<List<Map<String, dynamic>>> backupReminders() async {
    try {
      return _localDataSource.backupToJson();
    } catch (e) {
      throw RepositoryException('Failed to backup reminders: $e');
    }
  }

  /// Restore reminders from JSON format
  Future<void> restoreReminders(List<Map<String, dynamic>> jsonList) async {
    try {
      await _localDataSource.restoreFromJson(jsonList);
    } catch (e) {
      throw RepositoryException('Failed to restore reminders: $e');
    }
  }

  /// Optimize database
  Future<void> optimizeDatabase() async {
    try {
      await _localDataSource.compactDatabase();
    } catch (e) {
      throw RepositoryException('Failed to optimize database: $e');
    }
  }
}

/// Repository Exception
class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
