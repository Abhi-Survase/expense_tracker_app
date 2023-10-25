import 'package:uuid/uuid.dart';

const uid = Uuid();

enum Category { food, travel, work, fun }

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
}
