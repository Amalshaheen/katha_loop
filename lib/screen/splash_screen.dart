import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katha_loop/core/constants.dart';
import 'package:katha_loop/core/responsive_utils.dart';
import 'package:katha_loop/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.splashAnimationDuration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
              theme.colorScheme.tertiary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;
              
              if (isLandscape && !context.isMobile) {
                return _buildLandscapeLayout(theme, constraints);
              }
              return _buildPortraitLayout(theme, constraints);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(ThemeData theme, BoxConstraints constraints) {
    return Column(
      children: [
        // Background decoration
        Expanded(
          flex: 2,
          child: _buildBackgroundSection(theme, constraints),
        ),
        
        // Content section
        Expanded(
          flex: 3,
          child: _buildContentSection(theme, constraints),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(ThemeData theme, BoxConstraints constraints) {
    return Row(
      children: [
        // Background decoration
        Expanded(
          flex: 1,
          child: _buildBackgroundSection(theme, constraints),
        ),
        
        // Content section
        Expanded(
          flex: 1,
          child: _buildContentSection(theme, constraints),
        ),
      ],
    );
  }

  Widget _buildBackgroundSection(ThemeData theme, BoxConstraints constraints) {
    final imageSize = context.isMobile 
        ? constraints.maxWidth * 0.3 
        : constraints.maxWidth * 0.15;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AppConstants.splashBackgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.primary.withOpacity(0.3),
            BlendMode.overlay,
          ),
        ),
      ),
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              padding: EdgeInsets.all(context.isMobile ? AppSpacing.xl : AppSpacing.xxl),
              child: Center(
                child: AccessibilityHelper.makeAccessible(
                  semanticLabel: 'Paper airplane logo representing story adventure',
                  child: Image.asset(
                    AppConstants.paperAirplaneImage,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection(ThemeData theme, BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? AppSpacing.xl : AppSpacing.xxl,
        vertical: context.isMobile ? AppSpacing.xxl : AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.isMobile ? AppRadius.xl : AppRadius.lg),
        ),
      ),
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo/icon
              AccessibilityHelper.makeAccessible(
                semanticLabel: '${AppConstants.appName} app icon',
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.auto_stories_rounded,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              
              // App title
              AccessibilityHelper.makeAccessible(
                semanticLabel: '${AppConstants.appName} app title',
                child: Text(
                  AppConstants.appName,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: context.isMobile ? 32 : 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Subtitle
              AccessibilityHelper.makeAccessible(
                semanticLabel: 'App tagline: ${AppConstants.appTagline}',
                child: Text(
                  AppConstants.appTagline,
                  style: GoogleFonts.dancingScript(
                    fontSize: context.isMobile ? 24 : 28,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // CTA Button
              SizedBox(
                width: double.infinity,
                child: AccessibilityHelper.makeAccessible(
                  semanticLabel: 'Start button to begin story adventure',
                  hint: 'Tap to start creating stories',
                  child: FilledButton.icon(
                    onPressed: () {
                      context.go(Routes.chatScreen);
                    },
                    icon: const Icon(Icons.rocket_launch_rounded),
                    label: Text(
                      AppConstants.startAdventureButtonText,
                      style: TextStyle(
                        fontSize: context.isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: context.isMobile ? 16 : 20,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Secondary info
              AccessibilityHelper.makeAccessible(
                semanticLabel: 'App description: ${AppConstants.appDescription}',
                child: Text(
                  AppConstants.appDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: context.isMobile ? 14 : 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
