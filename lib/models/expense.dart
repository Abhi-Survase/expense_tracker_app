import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat("d MMM, ''yy");

const uid = Uuid();

enum Category { food, travel, work, liesure }

const categoryIcons = {
  Category.food: Icons.dinner_dining,
  Category.liesure: Icons.theaters,
  Category.travel: Icons.train,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
