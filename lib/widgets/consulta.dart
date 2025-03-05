import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/db/juego.dart';
import 'package:memo/db/sqlite.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  List<Juego> _juegos = []; // Lista de registros de la BD
  bool _isLoading = true; // Estado de carga
  int _totalVictorias = 0; // Contador de victorias
  int _totalDerrotas = 0; // Contador de derrotas

  @override
  void initState() {
    super.initState();
    _cargarDatos(); // Llamar a la función para obtener los datos
  }

  /// **✅ Obtener datos y calcular totales**
  Future<void> _cargarDatos() async {
    List<Juego> juegos = await Sqlite.consulta();

    int victorias = juegos.fold(0, (sum, item) => sum + (item.victorias ?? 0));
    int derrotas = juegos.fold(0, (sum, item) => sum + (item.derrotas ?? 0));

    setState(() {
      _juegos = juegos;
      _totalVictorias = victorias;
      _totalDerrotas = derrotas;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Estadísticas"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CupertinoActivityIndicator()) // Indicador de carga Cupertino
                  : _juegos.isEmpty
                      ? const Center(child: Text("No hay datos guardados."))
                      : CupertinoScrollbar(
                          child: ListView.builder(
                            itemCount: _juegos.length,
                            itemBuilder: (context, index) {
                              Juego juego = _juegos[index];
                              return CupertinoListTile(
                                leading: const Icon(CupertinoIcons.game_controller, color: CupertinoColors.activeBlue),
                                title: Text(
                                  "Victorias: ${juego.victorias}, Derrotas: ${juego.derrotas}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("Fecha: ${juego.fecha?.substring(0,10)}"),
                              );
                            },
                          ),
                        ),
            ),
            CupertinoTabBar(
              backgroundColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.check_mark_circled, color: CupertinoColors.systemGreen),
                  label: "Victorias: $_totalVictorias",
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.clear_circled, color: CupertinoColors.systemRed),
                  label: "Derrotas: $_totalDerrotas",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}