import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coco/core/router/app_router.dart';
import 'package:coco/core/theme/app_theme.dart';
import 'package:coco/core/constants/app_constants.dart';

/// Main entry point for the Coco app
/// Initializes all services and wraps app with ProviderScope
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run app with Riverpod ProviderScope
  runApp(const ProviderScope(child: CocoApp()));
}

/// Main App Widget
/// Configures MaterialApp with routing and theme
class CocoApp extends ConsumerWidget {
  const CocoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Can be made dynamic with settings later
      // Router configuration
      routerConfig: AppRouter.router,

      // Builder for additional configuration
      builder: (context, child) {
        return MediaQuery(
          // Prevent text scaling from affecting layout
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
