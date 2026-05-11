import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coco/core/constants/app_colors.dart';
import 'package:coco/core/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

/// Splash Page
/// Displays a magical 3-stage intro animation inspired by Pixar's Coco
/// Features warm sunset gradients and smooth transitions
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _stage1Controller;
  late AnimationController _stage2Controller;
  late AnimationController _stage3Controller;
  late AnimationController _buttonController;

  // Animations
  late Animation<double> _stage1FadeAnimation;
  late Animation<double> _stage1ScaleAnimation;
  late Animation<double> _stage2FadeAnimation;
  late Animation<double> _stage2ScaleAnimation;
  late Animation<double> _stage3FadeAnimation;
  late Animation<double> _stage3ScaleAnimation;
  late Animation<double> _buttonFadeAnimation;
  late Animation<double> _buttonSlideAnimation;

  // State
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Stage 1: Initial fade in
    _stage1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _stage1FadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _stage1Controller, curve: Curves.easeIn));
    _stage1ScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _stage1Controller, curve: Curves.easeOut),
    );

    // Stage 2: Glow effect
    _stage2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _stage2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _stage2Controller, curve: Curves.easeInOut),
    );
    _stage2ScaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _stage2Controller, curve: Curves.easeInOut),
    );

    // Stage 3: Final position
    _stage3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _stage3FadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _stage3Controller, curve: Curves.easeIn));
    _stage3ScaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _stage3Controller, curve: Curves.easeOut),
    );

    // Button animation
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));
    _buttonSlideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
  }

  Future<void> _startAnimationSequence() async {
    // Stage 1: Fade in logo
    await Future.delayed(const Duration(milliseconds: 300));
    await _stage1Controller.forward();

    // Stage 2: Glow effect
    await Future.delayed(const Duration(milliseconds: 200));
    await _stage2Controller.forward();
    await _stage2Controller.reverse();

    // Stage 3: Settle
    await Future.delayed(const Duration(milliseconds: 100));
    await _stage3Controller.forward();

    // Show button
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _showButton = true;
    });
    await _buttonController.forward();
  }

  @override
  void dispose() {
    _stage1Controller.dispose();
    _stage2Controller.dispose();
    _stage3Controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _onStartPressed() {
    context.go(AppConstants.routeDashboard);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.sunsetGradient,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated background circles for magical effect
              _buildBackgroundCircles(),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Logo and title animation
                    AnimatedBuilder(
                      animation: _stage1Controller,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _stage1FadeAnimation,
                          child: ScaleTransition(
                            scale: _stage1ScaleAnimation,
                            child: AnimatedBuilder(
                              animation: _stage2Controller,
                              builder: (context, _) {
                                return Transform.scale(
                                  scale: _stage2ScaleAnimation.value,
                                  child: AnimatedBuilder(
                                    animation: _stage3Controller,
                                    builder: (context, _) {
                                      return FadeTransition(
                                        opacity: _stage3FadeAnimation,
                                        child: ScaleTransition(
                                          scale: _stage3ScaleAnimation,
                                          child: _buildLogoSection(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Tagline
                    AnimatedBuilder(
                      animation: _stage3Controller,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _stage3FadeAnimation,
                          child: Text(
                            AppConstants.appTagline,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),

                    const Spacer(flex: 3),

                    // Start Now button
                    if (_showButton)
                      AnimatedBuilder(
                        animation: _buttonController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _buttonFadeAnimation,
                            child: Transform.translate(
                              offset: Offset(0, _buttonSlideAnimation.value),
                              child: _buildStartButton(),
                            ),
                          );
                        },
                      ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        // Top left circle
        Positioned(
          top: -100,
          left: -100,
          child: AnimatedBuilder(
            animation: _stage1Controller,
            builder: (context, child) {
              return Opacity(
                opacity: _stage1FadeAnimation.value * 0.15,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.goldenGlow.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom right circle
        Positioned(
          bottom: -150,
          right: -150,
          child: AnimatedBuilder(
            animation: _stage2Controller,
            builder: (context, child) {
              return Opacity(
                opacity: _stage2FadeAnimation.value * 0.2,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.pastelTurquoise.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Center glow
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _stage2Controller,
            builder: (context, child) {
              return Opacity(
                opacity: _stage2FadeAnimation.value * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main logo icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.goldenGlow.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_active_rounded,
            size: 60,
            color: AppColors.deepPurple,
          ),
        ),

        const SizedBox(height: 32),

        // App name
        Text(
          AppConstants.appName,
          style: GoogleFonts.poppins(
            fontSize: 56,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Decorative line
        Container(
          width: 80,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [Colors.transparent, Colors.white, Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _onStartPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Start Now',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_rounded, size: 24),
          ],
        ),
      ),
    );
  }
}
