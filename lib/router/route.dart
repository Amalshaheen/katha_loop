import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katha_loop/router/routes.dart';
import 'package:katha_loop/screen/chat_screen.dart';
import 'package:katha_loop/screen/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(initialLocation: Routes.splashScreen, routes: [
  GoRoute(
    path: Routes.splashScreen,
    pageBuilder: (context, state) => MaterialPage(
      child: SplashScreen(),
    ),
  ),
  GoRoute(
    path: Routes.chatScreen,
    builder: (context, state) => ChatScreen(),
  ),
  // GoRoute(
  //   path: Routes.howToPlayScreen,
  // ),
  // GoRoute(
  //   path: Routes.historyScreen,
  // ),
  // GoRoute(
  //   path: Routes.chatScreen,
  // ),
]);
