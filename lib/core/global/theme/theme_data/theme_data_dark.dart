import 'package:flutter/material.dart';
import 'package:flutter_compass_app/core/global/theme/app_colors/app_colors_dark.dart';

ThemeData get themeDataLDark => ThemeData(
      primaryColor: AppColorsDark.primaryColor,
      colorScheme: ColorScheme.dark().copyWith(
        primary: AppColorsDark.primaryColor,
        secondary: AppColorsDark.secondaryColor,
      ),
      iconTheme: IconThemeData(
        color: AppColorsDark.red,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: AppColorsDark.primaryTextColor), // Default body text
        bodyMedium:
            TextStyle(color: AppColorsDark.primaryTextColor), // Medium text
        bodySmall:
            TextStyle(color: AppColorsDark.primaryTextColor), // Small text
        titleLarge:
            TextStyle(color: AppColorsDark.primaryTextColor), // Large title
        titleMedium: TextStyle(color: AppColorsDark.primaryTextColor),
        titleSmall: TextStyle(color: AppColorsDark.primaryTextColor),
      ),
    );
