import 'package:expense_tracker_app/new_expense_overlay.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class ExpensesMain extends StatefulWidget {
  const ExpensesMain({super.key});
  @override
  State<ExpensesMain> createState() {
    return _ExpensesMainState();
  }
}

final List<Expense> registeredExpense = [
  Expense(
      title: 'Flutter Course',
      amount: 569,
      date: DateTime.now(),
      expcategory: ExpCategory.work),
  Expense(
      title: 'Oppenheimer',
      amount: 200,
      date: DateTime(2023, 10, 15),
      expcategory: ExpCategory.liesure),
];

class _ExpensesMainState extends State<ExpensesMain> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('The Chart'),
          Expanded(
            child: ExpensesList(),
          ),
        ],
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpense.length,
      itemBuilder: (context, index) => ExpenseItem(registeredExpense[index]),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        children: [
          Text(expense.title),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('₹ ${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(expcategoryIcons[expense.expcategory]),
                  const SizedBox(width: 4),
                  Text(expense.formattedDate),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
