import 'package:flutter/material.dart';
import 'package:expenses_app/expenses.dart';
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    141,
    81,
    152,
  ),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(
    255,
    86,
    70,
    204,
  ),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
