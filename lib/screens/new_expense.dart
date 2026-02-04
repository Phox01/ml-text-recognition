import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late String dropdownValue = 'Hello';
  String _title = '';
  String _costCenter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          spacing: 20,
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
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      readOnly: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor seleccione una fecha';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101));
                                        if (pickedDate != null) {
                                          _date.text = DateFormat("dd-MM-yyyy")
                                              .format(pickedDate);
                                        }
                                      },
                                    ),
                                  ],
                                )),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _date2,
                                      decoration: const InputDecoration(
                                          labelText: "Fin",
                                          hintText: "Seleccionar fecha",
                                          filled: true,
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: _date.text.isNotEmpty
                                                    ? DateFormat("dd-MM-yyyy")
                                                        .parse(_date.text)
                                                    : DateTime(2000),
                                                lastDate: DateTime(2101));
                                        if (pickedDate != null) {
                                          _date2.text = DateFormat("dd-MM-yyyy")
                                              .format(pickedDate);
                                        }
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            ),
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
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Aprobador",
                                  hintText: "Escribir nombre del aprobador",
                                  filled: true,
                                  prefixIcon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                            DropdownButtonFormField(
                              icon: Icon(Icons.arrow_drop_down),
                              decoration: const InputDecoration(
                                  labelText: "Centro de Costo",
                                  hintText:
                                      "Escribir nombre del centro de costo",
                                  filled: true,
                                  prefixIcon: Icon(Icons.business_center),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              items: [
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
                                  dropdownValue = value!;
                                });
                              },
                            ),
                            Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Cancelar"),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExpenseCreated()));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(39, 113, 194, 100),
                                    ),
                                    child: Text("Crear",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ])
                          ],
                        ))))));
  }
}
