import 'package:flutter/material.dart';

import '../app_colors/app_colors_light.dart';

ThemeData get themeDataLight => ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: AppColorsLight.primaryColor,
      useMaterial3: true,
    );
