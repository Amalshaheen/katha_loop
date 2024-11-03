import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/router/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorSchemeNew.background,
            ColorSchemeNew.background,
            ColorSchemeNew.background,
            ColorSchemeNew.background,
            ColorSchemeNew.secondary,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/paper_airplane.png',
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StyledIcon(Icons.circle),
              const Text(
                'Your Messed up Stories',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  context.go(Routes.chatScreen);
                },
                label: const Text('Go'),
                icon: const StyledIcon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}