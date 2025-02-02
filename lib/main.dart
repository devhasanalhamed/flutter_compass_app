import 'package:flutter/material.dart';
import 'package:flutter_compass_app/core/global/theme/theme_data/theme_data_dark.dart';

import 'compass_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Compass Application',
      theme: themeDataLDark,
      debugShowCheckedModeBanner: false,
      home: const CompassApp(),
    );
  }
}
