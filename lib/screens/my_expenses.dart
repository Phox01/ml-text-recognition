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
          Row(
            children: [
              Text("Seleccione el informe de gastos para visualizar"),
              ElevatedButton(
                onPressed: (){},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list, size:20),
                    Text("Filtrar"),
                    Icon(Icons.arrow_back_ios_sharp, size:20),
                    Text("Fecha")
                  ],
                )
              )

            ]
          )
        ]),
      ),
    );
  }
}
