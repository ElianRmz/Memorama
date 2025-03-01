import 'dart:async';

import 'package:flutter/material.dart';
import '../config/config.dart';
import 'stats.dart';
import 'parrilla.dart';

class Tablero extends StatefulWidget {
  final Nivel? nivel;
  const Tablero(this.nivel, {Key? key}) : super(key: key);

  @override
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

  void _maldito_elian_pone_bien_feas_los_nombre_de_las_variables_y_huele_feo() {
    if (parones == baraja.length ~/ 2) {
      _krono?.cancel();
      _mensajeVictoria();
    }
  }

  void _mensajeVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que se cierre con un clic fuera del diálogo
      builder: (context) {
        return AlertDialog(
          title: const Text("¡Felicidades! 🎉"),
          content: Text(
              "Has completado el nivel en $secs segundos con $moves movimientos."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
                Navigator.pop(context); // Regresar a la pantalla de inicio
              },
              child: const Text("Ir al inicio"),
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
