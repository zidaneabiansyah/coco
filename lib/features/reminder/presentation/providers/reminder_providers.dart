import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coco/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:coco/features/reminder/data/repositories/reminder_repository_impl.dart';
import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';
import 'package:coco/features/reminder/domain/repositories/reminder_repository.dart';

/// Provider for Reminder Local Data Source
/// Initializes Hive database and provides access to local storage
final reminderLocalDataSourceProvider = FutureProvider<ReminderLocalDataSource>(
  (ref) async {
    return await ReminderLocalDataSource.initialize();
  },
);

/// Provider for Reminder Repository
/// Provides implementation of repository interface
final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  final dataSource = ref.watch(reminderLocalDataSourceProvider).value;
  if (dataSource == null) {
    throw Exception('Data source not initialized');
  }
  return ReminderRepositoryImpl(dataSource);
});

/// Provider for All Reminders Stream
/// Watches all reminders in real-time
final allRemindersStreamProvider = StreamProvider<List<ReminderEntity>>((ref) {
  final repository = ref.watch(reminderRepositoryProvider);
  return repository.watchAllReminders();
});

/// Provider for All Reminders (Future)
/// Gets all reminders as a one-time fetch
final allRemindersProvider = FutureProvider<List<ReminderEntity>>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return await repository.getAllReminders();
});

/// Provider for Today's Reminders
/// Filters reminders for today only
final todayRemindersProvider = FutureProvider<List<ReminderEntity>>((
  ref,
) async {
  final repository = ref.watch(reminderRepositoryProvider);
  final reminders = await repository.getTodayReminders();

  // Sort by time (earliest first)
  reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return reminders;
});

/// Provider for This Week's Reminders
/// Filters reminders for current week
final weekRemindersProvider = FutureProvider<List<ReminderEntity>>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  final reminders = await repository.getWeekReminders();

  // Sort by time (earliest first)
  reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return reminders;
});

/// Provider for Completed Reminders
/// Filters only completed reminders
final completedRemindersProvider = FutureProvider<List<ReminderEntity>>((
  ref,
) async {
  final repository = ref.watch(reminderRepositoryProvider);
  final reminders = await repository.getCompletedReminders();

  // Sort by completion time (most recent first)
  reminders.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return reminders;
});

/// Provider for Active Reminders
/// Filters only pending/active reminders
final activeRemindersProvider = FutureProvider<List<ReminderEntity>>((
  ref,
) async {
  final repository = ref.watch(reminderRepositoryProvider);
  final reminders = await repository.getActiveReminders();

  // Sort by time (earliest first)
  reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return reminders;
});

/// Provider for Overdue Reminders
/// Filters only overdue reminders
final overdueRemindersProvider = FutureProvider<List<ReminderEntity>>((
  ref,
) async {
  final repository = ref.watch(reminderRepositoryProvider);
  final reminders = await repository.getOverdueReminders();

  // Sort by time (most overdue first)
  reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return reminders;
});

/// Provider for Single Reminder by ID
/// Family provider to get a specific reminder
final reminderByIdProvider = FutureProvider.family<ReminderEntity?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return await repository.getReminderById(id);
});

/// Provider for Reminders by Category
/// Family provider to filter by category
final remindersByCategoryProvider =
    FutureProvider.family<List<ReminderEntity>, ReminderCategory>((
      ref,
      category,
    ) async {
      final repository = ref.watch(reminderRepositoryProvider);
      final reminders = await repository.getRemindersByCategory(category);

      // Sort by time (earliest first)
      reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return reminders;
    });

/// Provider for Reminders by Priority
/// Family provider to filter by priority
final remindersByPriorityProvider =
    FutureProvider.family<List<ReminderEntity>, ReminderPriority>((
      ref,
      priority,
    ) async {
      final repository = ref.watch(reminderRepositoryProvider);
      final reminders = await repository.getRemindersByPriority(priority);

      // Sort by time (earliest first)
      reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return reminders;
    });

/// Provider for Search Reminders
/// Family provider to search reminders by query
final searchRemindersProvider =
    FutureProvider.family<List<ReminderEntity>, String>((ref, query) async {
      final repository = ref.watch(reminderRepositoryProvider);
      final reminders = await repository.searchReminders(query);

      // Sort by time (earliest first)
      reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return reminders;
    });

/// Provider for Reminders Count by Status
/// Family provider to get count by status
final remindersCountByStatusProvider =
    FutureProvider.family<int, ReminderStatus>((ref, status) async {
      final repository = ref.watch(reminderRepositoryProvider);
      return await repository.getRemindersCountByStatus(status);
    });

/// Provider for Total Reminders Count
final totalRemindersCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return await repository.getTotalRemindersCount();
});

/// State Notifier for Reminder Operations (CRUD)
/// Handles create, update, delete operations with loading states
class ReminderNotifier extends StateNotifier<AsyncValue<void>> {
  final ReminderRepository _repository;

  ReminderNotifier(this._repository) : super(const AsyncValue.data(null));

  /// Create a new reminder
  Future<void> createReminder(ReminderEntity reminder) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createReminder(reminder);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Update an existing reminder
  Future<void> updateReminder(ReminderEntity reminder) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateReminder(reminder);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Delete a reminder
  Future<void> deleteReminder(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteReminder(id);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Mark reminder as completed
  Future<void> markAsCompleted(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.markAsCompleted(id);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Mark reminder as cancelled
  Future<void> markAsCancelled(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.markAsCancelled(id);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Delete all completed reminders
  Future<void> deleteCompletedReminders() async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteCompletedReminders();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Provider for Reminder Notifier
/// Manages CRUD operations state
final reminderNotifierProvider =
    StateNotifierProvider<ReminderNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(reminderRepositoryProvider);
      return ReminderNotifier(repository);
    });

/// State Provider for Dashboard Filter
/// Manages which filter tab is active on dashboard
enum DashboardFilter {
  today,
  thisWeek,
  all,
  done;

  String get displayName {
    switch (this) {
      case DashboardFilter.today:
        return 'Today';
      case DashboardFilter.thisWeek:
        return 'This Week';
      case DashboardFilter.all:
        return 'All';
      case DashboardFilter.done:
        return 'Done';
    }
  }
}

final dashboardFilterProvider = StateProvider<DashboardFilter>((ref) {
  return DashboardFilter.today;
});

/// Provider for Filtered Reminders based on Dashboard Filter
/// Dynamically returns reminders based on selected filter
final filteredRemindersProvider = FutureProvider<List<ReminderEntity>>((
  ref,
) async {
  final filter = ref.watch(dashboardFilterProvider);

  switch (filter) {
    case DashboardFilter.today:
      return ref.watch(todayRemindersProvider.future);
    case DashboardFilter.thisWeek:
      return ref.watch(weekRemindersProvider.future);
    case DashboardFilter.all:
      final reminders = await ref.watch(allRemindersProvider.future);
      reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return reminders;
    case DashboardFilter.done:
      return ref.watch(completedRemindersProvider.future);
  }
});

/// Provider for Statistics Data
/// Calculates statistics for completed reminders
final reminderStatisticsProvider = FutureProvider<ReminderStatistics>((
  ref,
) async {
  final repository = ref.watch(reminderRepositoryProvider);

  final totalCount = await repository.getTotalRemindersCount();
  final completedCount = await repository.getRemindersCountByStatus(
    ReminderStatus.completed,
  );
  final activeCount = await repository.getRemindersCountByStatus(
    ReminderStatus.pending,
  );
  final overdueReminders = await repository.getOverdueReminders();

  // Calculate weekly stats
  final weekReminders = await repository.getWeekReminders();
  final completedThisWeek = weekReminders
      .where((r) => r.status == ReminderStatus.completed)
      .length;
  final totalThisWeek = weekReminders.length;

  // Calculate completion rate
  final completionRate = totalCount > 0
      ? (completedCount / totalCount * 100).round()
      : 0;

  final weeklyCompletionRate = totalThisWeek > 0
      ? (completedThisWeek / totalThisWeek * 100).round()
      : 0;

  return ReminderStatistics(
    totalReminders: totalCount,
    completedReminders: completedCount,
    activeReminders: activeCount,
    overdueCount: overdueReminders.length,
    completionRate: completionRate,
    weeklyCompleted: completedThisWeek,
    weeklyTotal: totalThisWeek,
    weeklyCompletionRate: weeklyCompletionRate,
  );
});

/// Statistics Data Class
class ReminderStatistics {
  final int totalReminders;
  final int completedReminders;
  final int activeReminders;
  final int overdueCount;
  final int completionRate; // Percentage
  final int weeklyCompleted;
  final int weeklyTotal;
  final int weeklyCompletionRate; // Percentage

  ReminderStatistics({
    required this.totalReminders,
    required this.completedReminders,
    required this.activeReminders,
    required this.overdueCount,
    required this.completionRate,
    required this.weeklyCompleted,
    required this.weeklyTotal,
    required this.weeklyCompletionRate,
  });
}
