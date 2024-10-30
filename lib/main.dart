import 'package:compass/compass_app.dart';
import 'package:compass/core/global/theme/theme_data/theme_data_light.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeDataLight,
      debugShowCheckedModeBanner: false,
      home: const CompassApp(),
    );
  }
}
