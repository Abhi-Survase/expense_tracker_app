import 'package:expense_tracker_app/chart.dart';
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
        title: 'Swipe to remove an expense',
        amount: 420,
        date: DateTime.now(),
        expcategory: ExpCategory.work),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet<dynamic>(
      useSafeArea: true,
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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Removed'),
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
    final screenWidth = MediaQuery.of(context).size.width;
    Widget displayContent = Center(
        child: Text(
      'Enter an expense to get started!',
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
    ));

    if (_registeredExpense.isNotEmpty) {
      displayContent = ExpensesList(
          registeredExpense: _registeredExpense,
          onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'My Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: (screenWidth < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: _registeredExpense),
                Expanded(
                  child: displayContent,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Chart(expenses: _registeredExpense)),
                Expanded(
                  child: displayContent,
                ),
              ],
            )),
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
        background: Container(
          // color: Theme.of(context).colorScheme.error,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5.5),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(12)),
        ),
        key: ValueKey(registeredExpense[index]),
        onDismissed: (direction) {
          onRemoveExpense(registeredExpense[index]);
        },
        child: ExpenseItem(registeredExpense[index]),
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('₹ ${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              Row(
                children: [
                  Icon(expcategoryIcons[expense.expcategory]),
                  const SizedBox(width: 4),
                  Text(expense.formattedDate,
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
