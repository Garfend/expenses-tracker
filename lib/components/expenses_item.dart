import 'package:expenses_app/models/category_icon.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      categoryIcon[expense.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
