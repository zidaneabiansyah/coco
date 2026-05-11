/// App Constants
/// Contains all constant values used throughout the application
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Coco';
  static const String appTagline = 'Your Magical Reminder Companion';
  static const String appVersion = '1.0.0';

  // Database
  static const String hiveBoxName = 'coco_reminders';
  static const String hiveSettingsBox = 'coco_settings';
  static const String hiveStatsBox = 'coco_statistics';

  // Notification Channel
  static const String notificationChannelId = 'coco_reminders_channel';
  static const String notificationChannelName = 'Coco Reminders';
  static const String notificationChannelDescription =
      'Notifications for scheduled reminders and tasks';

  // Shared Preferences Keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyThemeMode = 'theme_mode';
  static const String keyNotificationEnabled = 'notification_enabled';
  static const String keyVibrationEnabled = 'vibration_enabled';
  static const String keySoundEnabled = 'sound_enabled';
  static const String keyLastSyncTime = 'last_sync_time';

  // Route Names
  static const String routeSplash = '/';
  static const String routeAuth = '/auth';
  static const String routeDashboard = '/dashboard';
  static const String routeAddReminder = '/add-reminder';
  static const String routeEditReminder = '/edit-reminder';
  static const String routeReminderDetail = '/reminder-detail';
  static const String routeStatistics = '/statistics';
  static const String routeSettings = '/settings';

  // Dashboard Filter Tabs
  static const String filterToday = 'Today';
  static const String filterThisWeek = 'This Week';
  static const String filterAll = 'All';
  static const String filterDone = 'Done';

  // Reminder Status
  static const String statusPending = 'pending';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';
  static const String statusOverdue = 'overdue';

  // Reminder Priority
  static const String priorityHigh = 'high';
  static const String priorityMedium = 'medium';
  static const String priorityLow = 'low';

  // Reminder Category
  static const String categoryWork = 'Work';
  static const String categoryPersonal = 'Personal';
  static const String categoryHealth = 'Health';
  static const String categoryStudy = 'Study';
  static const String categoryOther = 'Other';

  // Repeat Options
  static const String repeatNone = 'none';
  static const String repeatDaily = 'daily';
  static const String repeatWeekly = 'weekly';
  static const String repeatMonthly = 'monthly';
  static const String repeatYearly = 'yearly';

  // Time Constants
  static const int splashDuration = 3; // seconds
  static const int animationDuration = 300; // milliseconds
  static const int debounceDelay = 500; // milliseconds
  static const int notificationLeadTime = 5; // minutes before reminder

  // UI Constants
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 24.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Card Constants
  static const double cardElevation = 4.0;
  static const double cardRadius = 20.0;

  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNoInternet = 'No internet connection available.';
  static const String errorEmptyTitle =
      'Please enter a title for the reminder.';
  static const String errorInvalidDate = 'Please select a valid date and time.';
  static const String errorPermissionDenied =
      'Permission denied. Please enable in settings.';

  // Success Messages
  static const String successReminderCreated =
      'Reminder created successfully! 🎉';
  static const String successReminderUpdated =
      'Reminder updated successfully! ✨';
  static const String successReminderDeleted = 'Reminder deleted successfully.';
  static const String successReminderCompleted =
      'Great job! Reminder completed! 🌟';

  // Validation
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxLocationLength = 200;

  // Date Format
  static const String dateFormatDisplay = 'EEEE, MMM dd, yyyy';
  static const String timeFormatDisplay = 'HH:mm';
  static const String dateTimeFormatDisplay = 'MMM dd, yyyy • HH:mm';

  // Statistics
  static const int daysInWeek = 7;
  static const int daysInMonth = 30;

  // Limits
  static const int maxRemindersPerDay = 50;
  static const int maxActiveReminders = 100;
}
