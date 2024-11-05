import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => formatter.format(date);
  
  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'category': category.toString(),
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        title: json['title'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
        category: Category.values.firstWhere(
          (e) => e.toString() == json['category'],
        ),
      );
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(
    List<Expense> allExpense,
    this.category,
  ) : expenses = allExpense.where(
              (expese) => expese.category == category,
            ).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double total = 0;
    for (final expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}
