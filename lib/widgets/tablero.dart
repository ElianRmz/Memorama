import 'package:memo/db/juego.dart';
import 'package:memo/db/sqlite.dart';

import 'bottom_c.dart';
import 'dart:async';
import 'package:bottom_cupertino_tabbar/bottom_cupertino_tabbar.dart';
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
  _TableroState createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
  List<Juego>? juego;
  int moves = 0;
  int parones = 0;
  int secs = 0;
  Key _parrillaKey = UniqueKey();
  Timer? _krono;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    openDB();
  }

  void _zomber() {
    _krono?.cancel();
    secs = 0;
    _krono = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => secs++);
    });
  }

  // Se llama cuando termina la animación de 3s en Parrilla
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
      _verificarGanador();
    });
  }

  void _verificarGanador() {
    if (parones == baraja.length ~/ 2) {
      _krono?.cancel();
      _mensajeVictoria();
      _registrarVictoria();
    }
  }

  void _mensajeVictoria() {
    _krono?.cancel();
    _krono = null;
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
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
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
    _krono?.cancel();
    _krono = null;

    setState(() {
      moves = 0;
      parones = 0;
      secs = 0;

      controles.clear();
      estados.clear();
      baraja.clear();

      // Cambiamos la key para forzar que Parrilla se reconstruya completamente
      _parrillaKey = UniqueKey();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _zomber();
    });
  }

  void _onBottomTap(int index) {
    if (index == 0 && _selectedIndex == 0) {
      return;
    }
    // Actualizamos el índice
    setState(() {
      _selectedIndex = index;
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
              _krono?.cancel();
              _krono = null;
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
      bottomNavigationBar: BottomC(
        selectedIndex: _selectedIndex,
        onTap: _onBottomTap,
        onExit: () {
          _krono?.cancel();
          _krono = null;
        },
        onReset: _resetGame,
      ),
    );
  }

  Future<void> openDB() async {
    await Sqlite.db();
  }

  Future<void> _registrarVictoria() async {
    final String fechaActual = DateTime.now()
        .toIso8601String(); // fecha en formato ISO
    Juego nuevaPartida = Juego(null, 1, 0, fechaActual);
    debugPrint("Registrado correctamente en la base de datos");

    await Sqlite.add([nuevaPartida]); 
  }
}
