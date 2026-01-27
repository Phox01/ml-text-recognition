import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _date2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo Gasto'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Center(
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text("Fecha de Inicio"),
                                    TextFormField(
                                      controller: _date,
                                      decoration: const InputDecoration(
                                          labelText: "Fecha de Inicio",
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
                                    Text("Fecha de Inicio"),
                                    TextFormField(
                                      controller: _date2,
                                      decoration: const InputDecoration(
                                          labelText: "Fecha de Inicio",
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
                                        DateTime? pickedDate2 =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: pickedDate,
                                                lastDate: DateTime(2101));
                                        if (pickedDate2 != null) {
                                          _date.text = DateFormat("dd-MM-yyyy")
                                              .format(pickedDate2);
                                        }
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ))))));
  }
}
