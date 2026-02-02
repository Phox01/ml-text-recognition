import 'package:flutter/material.dart';

class ExpenseCreated extends StatelessWidget {
  const ExpenseCreated({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nombre del Reporte de Gasto'),
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
                            color: Color.fromRGBO(0, 54, 99, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Título del Gasto",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const Text(
                                      "Bs 250.00",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  Text("Anticipo: Bs 0.00",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text("Aprobador:",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                      Text("Cecilio",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                                    ]),
                                  
                                  Text(
                                    "Abierto",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.orange),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Text("Centro de Costo:",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                          Text("0000000000",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Text("Fecha de Envío:",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                          Text(" 2 de febrero 2026",
                                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
                                ],
                              ),
                             
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text("Periodo:",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white)),
                                          Text(" 2 de febrero 2026-2 de febrero 2026",
                                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
                                
                                    ]
                                  ),
                                  
                                  TextButton.icon(
                                    onPressed:() {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                    icon: const Icon(Icons.edit),
                                    label: const Text("Editar"),
                                  ),
                                ],
                              ),
                            ],
                          ),),
                      SizedBox(height: 20),
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
                        child: Text("Comentarios")
                      ),
                      TextButton.icon(
                                    onPressed:() {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                    ),
                                    icon: const Icon(Icons.add),
                                    label: const Text("Agregar factura"),
                                  ),
                    ],
                  ))),
        ));
  }
}
