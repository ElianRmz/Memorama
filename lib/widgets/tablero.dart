import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/widgets/menu.dart';
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
  
  Key _parrillaKey = UniqueKey(); // Llave para resetear la parrilla 

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
    if (_krono != null) {
      _krono!.cancel();
      _krono = null;
    }
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
    if (_krono != null) {
      _krono!.cancel();
      _krono = null;
    }
    
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
                Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
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

  void _resetGame() {
    if (_krono != null) {
      _krono!.cancel();
      _krono = null;
    }

    setState(() {
      moves = 0;
      parones = 0;
      secs = 0;
      
      // Revisar si se tiene que limpiar o puedo resetearlo con lo de arriba.
      controles.clear();
      estados.clear();
      baraja.clear();
      
      _parrillaKey = UniqueKey(); // Se hace otra key para reiniciar
      
      // Restart the timer after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        _zomber();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel: ${widget.nivel?.name}"),
        actions: [
          Menu(
            onExit: () {
              // Cancel the timer when exiting
              if (_krono != null) {
                _krono!.cancel();
                _krono = null;
              }
            },
            nivel: widget.nivel,
            onReset: _resetGame,
          )
        ],
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
              key: _parrillaKey,
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
