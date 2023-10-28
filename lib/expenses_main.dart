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

class _ExpensesMainState extends State<ExpensesMain> {
  final List<Expense> _registeredExpense = [
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SizedBox(
        height: 550,
        child: NewExpense(onAddExpense: addExpense),
      ),
      //Sizedbox used to create a BottomSheet with constraints of size 550
    );
  }

  void addExpense(Expense expense) {
    //print(expense.title);
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Removes'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget displayContent =
        const Center(child: Text('Enter a expense to get started!'));

    if (_registeredExpense.isNotEmpty) {
      displayContent = ExpensesList(
          registeredExpense: _registeredExpense,
          onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('The Chart'),
          Expanded(
            child: displayContent,
          ),
        ],
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.registeredExpense,
      required this.onRemoveExpense});
  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> registeredExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpense.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(registeredExpense[index]),
          onDismissed: (direction) {
            onRemoveExpense(registeredExpense[index]);
          },
          child: ExpenseItem(registeredExpense[index])),
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
