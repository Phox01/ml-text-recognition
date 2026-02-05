import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewmodels/expense_view_model.dart';
import 'expense_created.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _date2 = TextEditingController();
  late String dropdownValue = 'Business 1';
  String _title = '';
  String _costCenter = '';
  String _approver = '';

  /// New explicit string fields for the dates (like `_title`)
  String _startDate = '';
  String _endDate = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo Reporte de Gasto'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // keep original spacing but use SizedBox where needed
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _date,
                                decoration: const InputDecoration(
                                  labelText: "Inicio",
                                  hintText: "Seleccionar fecha",
                                  filled: true,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue)),
                                  enabledBorder:
                                      OutlineInputBorder(borderSide: BorderSide.none),
                                ),
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor seleccione una fecha';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    final formatted = DateFormat("dd-MM-yyyy").format(pickedDate);
                                    _date.text = formatted;
                                    _startDate = formatted; // store string value
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _date2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor seleccione una fecha';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Fin",
                                  hintText: "Seleccionar fecha",
                                  filled: true,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue)),
                                  enabledBorder:
                                      OutlineInputBorder(borderSide: BorderSide.none),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: _date.text.isNotEmpty
                                          ? DateFormat("dd-MM-yyyy").parse(_date.text)
                                          : DateTime(2000),
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    final formatted = DateFormat("dd-MM-yyyy").format(pickedDate);
                                    _date2.text = formatted;
                                    _endDate = formatted; // store string value
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un título';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Título del reporte",
                        hintText: "Escribir título del reporte",
                        filled: true,
                        prefixIcon: Icon(Icons.title),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un aprobador';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _approver = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Aprobador",
                        hintText: "Escribir nombre del aprobador",
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un Centro de Costo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _costCenter = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Centro de Costo",
                        hintText: "Escribir nombre del centro de costo",
                        filled: true,
                        prefixIcon: Icon(Icons.business_center),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Business 1",
                          child: Text("Business 1"),
                        ),
                        DropdownMenuItem(
                          value: "Business 2",
                          child: Text("Business 2"),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value ?? dropdownValue;
                        });
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar"),
                        ),
                        const SizedBox(width: 20),
                        Consumer<ExpenseViewModel>(builder: (context, vm, _) {
                          return ElevatedButton(
                            onPressed: vm.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      // build the JSON (all vars in a JSON)
                                      final Map<String, dynamic> json = {
                                        'startDate': _startDate,
                                        'endDate': _endDate,
                                        'title': _title,
                                        'approver': _approver,
                                        'costCenter': _costCenter,
                                      };
                                      // you can inspect the json in debug
                                      // ignore: avoid_print
                                      print('Expense JSON: $json');

                                      try {
                                        final expense = await vm.createExpense(
                                          startDate: _startDate,
                                          endDate: _endDate,
                                          title: _title,
                                          approver: _approver,
                                          costCenter: _costCenter,
                                        );

                                        // ensure widget still mounted before navigation
                                        if (!mounted) return;

                                        // pass the created object to the success screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ExpenseCreated(expense: expense),
                                          ),
                                        );
                                      } catch (e) {
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Error creando el gasto: $e')),
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(39, 113, 194, 100),
                            ),
                            child: vm.isLoading
                                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text("Crear", style: TextStyle(color: Colors.white)),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
