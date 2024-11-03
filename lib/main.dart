import 'package:flutter/material.dart';

import 'package:katha_loop/router/route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      
      routerConfig: router,
    );
  }
}
