import 'package:expenses_app/components/expenses_item.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expense,
    required this.onRemoveExpense,
  });

  final List<Expense> expense;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: Theme.of(context).cardTheme.margin,
        ),      
        key: ValueKey(
          expense[index],
        ),
        onDismissed: (directon) {
          onRemoveExpense(
            expense[index],
          );
        },
        child: ExpensesItem(
          expense[index],
        ),
      ),
    );
  }
}
