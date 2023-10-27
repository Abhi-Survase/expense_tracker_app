import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat("d MMM, ''yy");

const uid = Uuid();

enum ExpCategory { food, travel, work, liesure }

const expcategoryIcons = {
  ExpCategory.food: Icons.dinner_dining,
  ExpCategory.liesure: Icons.theaters,
  ExpCategory.travel: Icons.train,
  ExpCategory.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.expcategory})
      : id = uid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpCategory expcategory;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
