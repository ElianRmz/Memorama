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
  int moves = 0;
  int parones = 0;
  int secs = 0;
  Timer? _krono;

  // Índice de la barra inferior (0 = Game)
  int _selectedIndex = 0;

  // Inicia/reinicia el cronómetro
  void _zomber() {
    _krono?.cancel();
    secs = 0;
    _krono = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secs++;
      });
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
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("¡Felicidades! "),
          content: Text(
              "Has completado el nivel en $secs segundos con $moves movimientos."),
          actions: [
            TextButton(
              onPressed: () {
                _krono?.cancel();
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

  /// Maneja los taps de la barra inferior
  void _onBottomTap(int index) {
    // Si es el botón "Game" (índice 0) y ya estamos en 0, no hacemos nada
    if (index == 0 && _selectedIndex == 0) {
      return;
    }
    // Actualizamos el índice
    setState(() {
      _selectedIndex = index;
    });

    // Puedes poner la lógica que necesites según el botón
    switch (index) {
      case 1:
        debugPrint("Botón Salir pulsado");
        // Por ejemplo: Navigator.pop(context);
        break;
      case 2:
        debugPrint("Botón Reiniciar pulsado");
        // Lógica para reiniciar, si corresponde
        break;
      case 3:
        debugPrint("Botón Juego nuevo pulsado");
        // Lógica para juego nuevo
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel: ${widget.nivel?.name}"),
        actions: [
          // Mantienes tu botón "Menu" con su callback
          Menu(
            onExit: () {
              _krono?.cancel();
            },
          )
        ],
      ),

      // Tu contenido principal
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

      // En vez de bottomSheet, usamos bottomNavigationBar
      bottomNavigationBar: BottomC(
        selectedIndex: _selectedIndex,
        onTap: _onBottomTap,
        onExit: () {
          _krono?.cancel();
        },
      ),
    );
  }
}
