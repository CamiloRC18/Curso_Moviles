import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seed = Color.fromARGB(255, 30, 116, 52);

  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: _seed,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: _colorScheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: _colorScheme.inversePrimary,
      centerTitle: true,
      elevation: 2,
      titleTextStyle: TextStyle(
        color: _colorScheme.onInverseSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: _colorScheme.onInverseSurface),
      actionsIconTheme: IconThemeData(color: _colorScheme.onInverseSurface),
    ),
  );
}
