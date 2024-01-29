import 'package:expense_tracker_app/expenses_main.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 37, 8, 127),
);
final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Colors.lightBlue);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MediaQuery.sizeOf();
  // SystemChrome.setPreferredOrientations(     // Set single orientation
  //   [DeviceOrientation.portraitUp],
  // ).then( (value) =>
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: kDarkColorScheme.primary,
            backgroundColor: kDarkColorScheme.onPrimary,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: kColorScheme.primaryContainer,
        colorScheme: kColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: kColorScheme.primary,
              backgroundColor: kColorScheme.onPrimary),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.inversePrimary,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5.5),
        ),
        textTheme: const TextTheme().copyWith(
          titleSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.5,
            color: kColorScheme.onSecondaryContainer,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      home: const ExpensesMain(),
    ),
    // ),
  );
}
