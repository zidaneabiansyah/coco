import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coco/features/splash/presentation/pages/splash_page.dart';
import 'package:coco/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:coco/features/reminder/presentation/pages/add_reminder_page.dart';
import 'package:coco/features/reminder/presentation/pages/edit_reminder_page.dart';
import 'package:coco/features/reminder/presentation/pages/reminder_detail_page.dart';
import 'package:coco/features/statistics/presentation/pages/statistics_page.dart';
import 'package:coco/core/constants/app_constants.dart';

/// App Router Configuration
/// Manages navigation throughout the application using GoRouter
class AppRouter {
  AppRouter._();

  /// Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.routeSplash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen Route
      GoRoute(
        path: AppConstants.routeSplash,
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Dashboard Route
      GoRoute(
        path: AppConstants.routeDashboard,
        name: 'dashboard',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),

      // Add Reminder Route
      GoRoute(
        path: AppConstants.routeAddReminder,
        name: 'add-reminder',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AddReminderPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      ),

      // Edit Reminder Route
      GoRoute(
        path: '${AppConstants.routeEditReminder}/:id',
        name: 'edit-reminder',
        pageBuilder: (context, state) {
          final reminderId = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: EditReminderPage(reminderId: reminderId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;

                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
          );
        },
      ),

      // Reminder Detail Route
      GoRoute(
        path: '${AppConstants.routeReminderDetail}/:id',
        name: 'reminder-detail',
        pageBuilder: (context, state) {
          final reminderId = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ReminderDetailPage(reminderId: reminderId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutCubic,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
          );
        },
      ),

      // Statistics Route
      GoRoute(
        path: AppConstants.routeStatistics,
        name: 'statistics',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StatisticsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      ),
    ],

    // Error page builder
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 24),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go(AppConstants.routeDashboard),
              icon: const Icon(Icons.home),
              label: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );

  /// Navigate to Dashboard
  static void goToDashboard(BuildContext context) {
    context.go(AppConstants.routeDashboard);
  }

  /// Navigate to Add Reminder
  static void goToAddReminder(BuildContext context) {
    context.push(AppConstants.routeAddReminder);
  }

  /// Navigate to Edit Reminder
  static void goToEditReminder(BuildContext context, String reminderId) {
    context.push('${AppConstants.routeEditReminder}/$reminderId');
  }

  /// Navigate to Reminder Detail
  static void goToReminderDetail(BuildContext context, String reminderId) {
    context.push('${AppConstants.routeReminderDetail}/$reminderId');
  }

  /// Navigate to Statistics
  static void goToStatistics(BuildContext context) {
    context.push(AppConstants.routeStatistics);
  }

  /// Go back
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppConstants.routeDashboard);
    }
  }
}
