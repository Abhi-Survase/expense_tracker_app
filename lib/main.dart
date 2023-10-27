import 'package:expense_tracker_app/expenses_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: const ExpensesMain(),
  ));
}
