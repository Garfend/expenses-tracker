import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/expenses_list.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? expensesString = prefs.getString('expenses');
    if (expensesString != null) {
      final List<dynamic> expensesJson = jsonDecode(expensesString);
      setState(() {
        _registeredExpenses.addAll(
          expensesJson.map((json) => Expense.fromJson(json)).toList(),
        );
      });
    }
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String expensesString = jsonEncode(
      _registeredExpenses.map((expense) => expense.toJson()).toList(),
    );
    await prefs.setString('expenses', expensesString);
  }

  void _addExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpene: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    _saveExpenses();
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    _saveExpenses();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
            _saveExpenses();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses added yet'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expense: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter expense tracker'),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}