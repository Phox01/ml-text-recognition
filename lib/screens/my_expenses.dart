import 'package:flutter/material.dart';

class MyExpenses extends StatefulWidget {
  const MyExpenses({super.key});

  @override
  State<MyExpenses> createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {
  bool isRecognizing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mis Gastos'),
        actions: [
          IconButton(
              iconSize: 40,
              splashRadius: 40,
              icon: const Icon(Icons.add_circle_sharp),
              tooltip: 'Agregar Gasto',
              onPressed: () {},
              color: Colors.white),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Total Gastos"),
                                Text("\$ 250.00"),
                              ]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Total Gastos"),
                                Text("\$ 250.00"),
                              ]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Total Gastos"),
                                Text("\$ 250.00"),
                              ]),
                        ),
                      ),
                    ]),
                SizedBox(height: 10),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total Gastos"),
                        Text("\$ 250.00"),
                      ]),
                ),
              ])),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seleccione el informe de gastos para visualizar",
                          style: TextStyle(fontSize: 11)),
                      Row(children: [
                        IconButton(
                            iconSize: 20,
                            splashRadius: 20,
                            icon: const Icon(Icons.filter_list),
                            tooltip: 'Agregar Gasto',
                            onPressed: () {},
                            color: Colors.blueAccent),
                        IconButton(
                            iconSize: 20,
                            splashRadius: 20,
                            icon: const Icon(Icons.sort),
                            tooltip: "Sort",
                            onPressed: () {},
                            color: Colors.blueAccent)
                      ]),
                    ]),
                Row(children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Abiertos"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Pendientes"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(Size(40, 40)),
                    ),
                    child: const Text("Aprobados"),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: const Text("Todos"),
                  // )
                ]),
                Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 37, 44, 99),
                    ),
                    
                    child: Column(children: [
                      Row(children: [
                        Icon(Icons.keyboard_option_key),
                        Text("No hay gastos para mostrar")
                      ])
                    ]))
              ])),
        ]),
      ),
    );
  }
}
