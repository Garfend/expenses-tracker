import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpene});
  final Function(Expense expense) onAddExpene;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _showDatepicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void dataValidation() {
    final enteredAmount = double.tryParse(_amountController.text);
    final validateAmount = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        validateAmount ||
        _selectedDate == null) {
      //new condition
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please enter valid title and amount'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpene(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return  SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (width > 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              labelText: 'Amount',
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'save expense'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _showDatepicker,
                              icon: const Icon(Icons.calendar_today),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          dataValidation();
                        },
                        child: const Text('save expense'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
