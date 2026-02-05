import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'recognize_receipt.dart';

class ExpenseCreated extends StatelessWidget {
  final Expense expense;

  const ExpenseCreated({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense.title.isNotEmpty ? expense.title : 'Reporte creado'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 54, 99, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expense.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Text(
                            "Bs 0.00",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Anticipo: Bs 0.00",
                              style: TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Aprobador:",
                                  style: TextStyle(fontSize: 12, color: Colors.white)),
                              Text(expense.approver,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Text(
                            "Abierto",
                            style: TextStyle(fontSize: 12, color: Colors.orange),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Centro de Costo:",
                              style: TextStyle(fontSize: 12, color: Colors.white)),
                          Text(expense.costCenter,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Periodo:",
                              style: TextStyle(fontSize: 12, color: Colors.white)),
                          Text('${expense.startDate} - ${expense.endDate}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.edit),
                            label: const Text("Editar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.all(16),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text("Comentarios")),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecognizeReceipt()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar factura"),
                ),
              ],
            ),
          ),                                   
        ),
      ),
    );
  }
}
