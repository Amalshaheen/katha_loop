import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katha_loop/router/routes.dart';
import 'package:katha_loop/screen/chat_screen.dart';
import 'package:katha_loop/screen/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.splashScreen, 
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      name: 'splash',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: Routes.chatScreen,
      name: 'chat',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ChatScreen(),
      ),
    ),
    // Future routes can be added here
    // GoRoute(
    //   path: Routes.howToPlayScreen,
    //   name: 'howToPlay',
    //   pageBuilder: (context, state) => MaterialPage(
    //     key: state.pageKey,
    //     child: const HowToPlayScreen(),
    //   ),
    // ),
    // GoRoute(
    //   path: Routes.historyScreen,
    //   name: 'history',
    //   pageBuilder: (context, state) => MaterialPage(
    //     key: state.pageKey,
    //     child: const HistoryScreen(),
    //   ),
    // ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Page not found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'The page "${state.location}" could not be found.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.splashScreen),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  ),
);
