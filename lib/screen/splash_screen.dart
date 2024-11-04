import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/router/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/splash_screen.jpeg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/paper_airplane.png',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                'Your Messed up Stories',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  color: Colors.deepOrange,
                  fontSize: 50,
                  shadows: [
                    Shadow(color: ColorSchemeNew.background, blurRadius: 10)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: ButtonStyle().copyWith(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorSchemeNew.secondary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  context.go(Routes.chatScreen);
                },
                label: const Text(
                  "Lets Go...",
                  style: TextStyle(
                    color: ColorSchemeNew.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
