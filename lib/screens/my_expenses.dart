import 'package:flutter/material.dart';
import 'package:ml_text_recognition/screens/new_expense.dart';

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
              onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewExpense(),
                              ),
                            );
                          },
              color: Colors.blue[400]),
        ],
        backgroundColor: Colors.white,
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Abierto (1)"),
                                Text("Bs 250.00",
                              style: TextStyle(fontSize: 18)),
                              ]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Pendiente"),
                                Text("Bs 250.00",
                              style: TextStyle(fontSize: 18)),
                              ]),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Aprobado"),
                                Text("Bs 250.00",
                              style: TextStyle(fontSize: 18)),
                              ]),
                        ),
                      ),
                    ]),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Anticipos",
                              style: TextStyle(fontSize: 15, color: Color.fromRGBO(39, 113, 194, 100))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total:"),
                              Text("\$ 500.00",
                              style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Por Reportar:"),
                                Text("\$ 150.00",
                              style: TextStyle(fontSize: 18)),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Por Registrar:"),
                              Text("\$ 350.00",
                              style: TextStyle(fontSize: 18)),
                            ],
                          )
                        ])
                      ]),
                ),
              ])),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Seleccione el gasto para visualizar",
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                            // style: ButtonStyle(
                            //   fixedSize: WidgetStateProperty.all(Size(100, 40)),
                            // ),
                            child: const Text("Aprobados"),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: const Text("Todos"),
                          // )
                        ]),
                  ])),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 6,
            itemBuilder: (context, index) {
              final items = [
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
                Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 54, 99, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.list_alt_rounded,
                                          color: Colors.white, size: 15),
                                      const SizedBox(width: 8),
                                      Text("8 de diciembre 2025 12:35",
                                          style: TextStyle(color: Colors.white))
                                    ]),
                                Text("Bs  0.00",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text("Prueba de Gasto",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Abierto",
                                    style: TextStyle(
                                        color: Colors.orange[900],
                                        fontSize: 14))
                              ])
                        ])),
              ];
              return items[index];
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ))
        ]),
      ),
    );
  }
}
