import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coco/core/constants/app_colors.dart';
import 'package:coco/core/constants/app_constants.dart';
import 'package:coco/core/router/app_router.dart';
import 'package:coco/core/extensions/datetime_extensions.dart';
import 'package:coco/features/reminder/presentation/providers/reminder_providers.dart';
import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dashboard Page
/// Main screen displaying reminders with filter tabs
/// Features: Today, This Week, All, Done filters
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final filters = [
        DashboardFilter.today,
        DashboardFilter.thisWeek,
        DashboardFilter.all,
        DashboardFilter.done,
      ];
      ref.read(dashboardFilterProvider.notifier).state =
          filters[_tabController.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF5EB), AppColors.backgroundLight],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              _buildFilterTabs(),
              Expanded(child: _buildReminderList()),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final statsAsync = ref.watch(reminderStatisticsProvider);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello! 👋',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your Reminders',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => AppRouter.goToStatistics(context),
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    color: AppColors.deepPurple,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          statsAsync.when(
            data: (stats) => _buildStatsCard(stats),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ReminderStatistics stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.magicalGradient),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepPurple.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.notifications_active_rounded,
            label: 'Active',
            value: stats.activeReminders.toString(),
          ),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
          _buildStatItem(
            icon: Icons.check_circle_rounded,
            label: 'Done',
            value: stats.completedReminders.toString(),
          ),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
          _buildStatItem(
            icon: Icons.trending_up_rounded,
            label: 'Rate',
            value: '${stats.completionRate}%',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.deepPurple,
        unselectedLabelColor: AppColors.textTertiary,
        labelStyle: GoogleFonts.nunito(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.nunito(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        indicator: BoxDecoration(
          color: AppColors.deepPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorPadding: const EdgeInsets.all(4),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Today'),
          Tab(text: 'This Week'),
          Tab(text: 'All'),
          Tab(text: 'Done'),
        ],
      ),
    );
  }

  Widget _buildReminderList() {
    final remindersAsync = ref.watch(filteredRemindersProvider);

    return remindersAsync.when(
      data: (reminders) {
        if (reminders.isEmpty) {
          return _buildEmptyState();
        }
        return _buildReminderCards(reminders);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.pastelTurquoise.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_rounded,
              size: 80,
              color: AppColors.pastelTurquoise.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Reminders Yet',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Tap the + button to create your first magical reminder',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: GoogleFonts.nunito(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCards(List<ReminderEntity> reminders) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        return _buildReminderCard(reminders[index]);
      },
    );
  }

  Widget _buildReminderCard(ReminderEntity reminder) {
    final categoryColor = _getCategoryColor(reminder.category);
    final priorityColor = _getPriorityColor(reminder.priority);

    return GestureDetector(
      onTap: () => AppRouter.goToReminderDetail(context, reminder.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: categoryColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Priority indicator (left border)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 6, color: priorityColor),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Category icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getCategoryIcon(reminder.category),
                            color: categoryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title and category
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reminder.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                reminder.category.displayName,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: categoryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Status badge
                        if (reminder.status == ReminderStatus.completed)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Done',
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    if (reminder.description.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        reminder.description,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Time and location
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: reminder.isOverdue
                              ? AppColors.error
                              : AppColors.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          reminder.dateTime.notificationFormat,
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            color: reminder.isOverdue
                                ? AppColors.error
                                : AppColors.textSecondary,
                            fontWeight: reminder.isOverdue
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        if (reminder.location != null &&
                            reminder.location!.isNotEmpty) ...[
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              reminder.location!,
                              style: GoogleFonts.nunito(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => AppRouter.goToAddReminder(context),
      icon: const Icon(Icons.add_rounded, size: 28),
      label: Text(
        'Add Reminder',
        style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.warmOrange,
      elevation: 8,
    );
  }

  Color _getCategoryColor(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.work:
        return AppColors.categoryWork;
      case ReminderCategory.personal:
        return AppColors.categoryPersonal;
      case ReminderCategory.health:
        return AppColors.categoryHealth;
      case ReminderCategory.study:
        return AppColors.categoryStudy;
      case ReminderCategory.other:
        return AppColors.categoryOther;
    }
  }

  Color _getPriorityColor(ReminderPriority priority) {
    switch (priority) {
      case ReminderPriority.high:
        return AppColors.priorityHigh;
      case ReminderPriority.medium:
        return AppColors.priorityMedium;
      case ReminderPriority.low:
        return AppColors.priorityLow;
    }
  }

  IconData _getCategoryIcon(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.work:
        return Icons.work_rounded;
      case ReminderCategory.personal:
        return Icons.person_rounded;
      case ReminderCategory.health:
        return Icons.favorite_rounded;
      case ReminderCategory.study:
        return Icons.school_rounded;
      case ReminderCategory.other:
        return Icons.more_horiz_rounded;
    }
  }
}
