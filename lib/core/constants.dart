class AppConstants {
  // App Information
  static const String appName = 'Katha Loop';
  static const String appTagline = 'Your Messed up Stories';
  static const String appDescription = 'Create endless absurd scenarios\nwith AI-powered storytelling';
  
  // UI Text
  static const String startAdventureButtonText = "Let's Begin the Adventure";
  static const String startStoryTitle = 'Start Your Story Adventure';
  static const String startStoryDescription = 'Type a message below to begin creating\nyour messed up story with AI!';
  static const String storySuggestions = 'Try starting with:\n"Once upon a time..." or "In a world where..."';
  static const String messageHint = 'Type your story prompt...';
  static const String loadingMessage = 'Crafting your story...';
  static const String errorMessage = 'Failed to generate story';
  
  // Routes
  static const String splashRoute = '/splash';
  static const String chatRoute = '/chat';
  
  // Assets
  static const String splashBackgroundImage = 'assets/splash_screen.jpeg';
  static const String paperAirplaneImage = 'assets/paper_airplane.png';
  static const String logoImage = 'assets/logo.jpg';
  
  // Animation Durations
  static const Duration splashAnimationDuration = Duration(milliseconds: 1500);
  static const Duration messageScrollDuration = Duration(milliseconds: 300);
  
  // API and Storage Keys
  static const String chatHistoryKey = 'chat_history';
  static const String userPreferencesKey = 'user_preferences';
}