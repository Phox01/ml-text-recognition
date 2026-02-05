import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ExpenseService {
  final String baseUrl;

  ExpenseService({this.baseUrl = 'http://localhost:3000'});

  /// Sends a POST to the Node backend (example: POST /expenses)
  Future<http.Response> createExpense(Expense expense) async {
    final url = Uri.parse('$baseUrl/expenses');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(expense.toJson()),
    );
    return response;
  }
}
