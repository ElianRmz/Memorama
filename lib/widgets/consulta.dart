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
  List<Juego> _juegos = []; // Lista para almacenar los datos de la BD
  bool _isLoading = true; // Estado de carga

  @override
  void initState() {
    super.initState();
    _cargarDatos(); // Llamar a la función para obtener los datos
  }

  /// **✅ Método para obtener los datos de la BD**
  Future<void> _cargarDatos() async {
    List<Juego> juegos = await Sqlite.consulta();
    setState(() {
      _juegos = juegos;
      _isLoading = false; // Una vez cargados, cambiamos el estado de carga
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Muestra un indicador de carga
          : _juegos.isEmpty
              ? const Center(child: Text("No hay datos guardados."))
              : ListView.builder(
                  itemCount: _juegos.length,
                  itemBuilder: (context, index) {
                    Juego juego = _juegos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      elevation: 3,
                      child: ListTile(
                        leading: const Icon(Icons.sports_esports, color: Colors.blue),
                        title: Text(
                          "Victoria: ${juego.victorias}, Derrota: ${juego.derrotas}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Fecha: ${juego.fecha}"),
                      ),
                    );
                  },
                ),
    );
  }
}
