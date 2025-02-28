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
    });
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
