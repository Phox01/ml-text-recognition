import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseService _service;

  ExpenseViewModel({ExpenseService? service}) : _service = service ?? ExpenseService();

  bool isLoading = false;
  String? error;

  Future<Expense> createExpense({
    required String startDate,
    required String endDate,
    required String title,
    required String approver,
    required String costCenter,
  }) async {
    final expense = Expense(
      startDate: startDate,
      endDate: endDate,
      title: title,
      approver: approver,
      costCenter: costCenter,
    );
    return expense;

    // try {
    //   isLoading = true;
    //   notifyListeners();
    //   final response = await _service.createExpense(expense);

    //   if (response.statusCode == 201 || response.statusCode == 200) {
    //     isLoading = false;
    //     notifyListeners();
    //     return expense;
    //   } else {
    //     error = 'Server error: ${response.statusCode}';
    //     isLoading = false;
    //     notifyListeners();
    //     throw Exception(error);
    //   }
    // } catch (e) {
    //   isLoading = false;
    //   error = e.toString();
    //   notifyListeners();
    //   rethrow;
    // }
  }
}
