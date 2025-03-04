import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

/*
Este es el espacio donde se va
 */
class _ConsultaState extends State<Consulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estadísticas"),
      ),
      body: ListView(),
    );
  }
}
