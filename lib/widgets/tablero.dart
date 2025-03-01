import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';
import 'stats.dart';
import 'parrilla.dart';

class Tablero extends StatefulWidget {
  final Nivel? nivel;
  const Tablero(this.nivel, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TableroState createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
  int moves = 0;
  int parones = 0;
  int secs = 0;

  Timer? _krono;

  void _zomber() {
    _krono?.cancel();
    secs = 0;

    _krono = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secs++;
      });
    });
  }

  void fini() {
    _zomber();
  }

  @override
  void dispose() {
    _krono?.cancel();
    super.dispose();
  }

  void movio() {
    setState(() {
      moves++;
    });
  }

  void encontro() {
    setState(() {
      parones++;
      _maldito_elian_pone_bien_feas_los_nombre_de_las_variables_y_huele_feo();
    });
  }

  // ignore: non_constant_identifier_names
  void _maldito_elian_pone_bien_feas_los_nombre_de_las_variables_y_huele_feo() {
    if (parones == baraja.length ~/ 2) {
      _krono?.cancel();
      _mensajeVictoria();
    }
  }

  void _mensajeVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("¡Felicidades! "),
          content: Text(
              "Has completado el nivel en $secs segundos con $moves movimientos."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Inicio",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel: ${widget.nivel?.name}"),
      ),
      body: Column(
        children: [
          Stats(
            moves: moves,
            paro: parones,
            secs: secs,
          ),
          Expanded(
            child: Parrilla(
              nivel: widget.nivel,
              volt: movio,
              bonjorno: encontro,
              fini: fini,
            ),
          ),
        ],
      ),
    );
  }
}
