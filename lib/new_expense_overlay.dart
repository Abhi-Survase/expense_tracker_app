import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat("d MMM, ''yy");

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleInputController = TextEditingController();
  final _amountInputCOntroller = TextEditingController();
  DateTime? _selectedDate;
  ExpCategory _selectedCategory = ExpCategory.leisure;

  void _createDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // one method of getting the value
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    ); //.then((value) => null) //one way of gettting the values
    // next line will run only after the value is saved in the await fnc
    //print(selectedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountInputCOntroller.text);
    final List<String> errormsg = ['Expense title\n', 'Amount\n', 'Date'];
    String err = 'Please enter valid inputs for :\n';

    if (_titleInputController.text.trim().isEmpty == true ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      if (_titleInputController.text.trim().isEmpty == true) {
        err += errormsg[0];
      }
      if (enteredAmount == null || enteredAmount <= 0) {
        err += errormsg[1];
      }
      if (_selectedDate == null) {
        err += errormsg[2];
      }
      //print(err);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.system_security_update_warning_rounded),
          title: Text('Invalid Input',
              style: Theme.of(context).textTheme.titleMedium),
          content: Text(err, style: Theme.of(context).textTheme.titleSmall),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Re-Enter'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleInputController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          expcategory: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    _amountInputCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardspacing = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: keyboardspacing + 16, right: 16.0, left: 16.0, top: 16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleInputController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Title')),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountInputCOntroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      prefixText: '₹ ',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        (_selectedDate == null)
                            ? 'No Date Selected'
                            : dateFormatter.format(_selectedDate!),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall // ! forces flutter to assume a datatype? will never be null
                        ),
                    IconButton(
                      onPressed: _createDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: ExpCategory.values
                      .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name.toUpperCase(),
                          )))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                    //print(value);
                  },
                ),
                const Spacer(),
                TextButton(
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
