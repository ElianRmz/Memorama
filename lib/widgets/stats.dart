import 'package:flutter/material.dart';
import 'package:memo/config/config.dart';

class Stats extends StatelessWidget {
  final int moves;
  final int paro;
  final int secs;

  const Stats({
    Key? key,
    required this.moves,
    required this.paro,
    required this.secs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Opcional: convertir elapsedSeconds a formato mm:ss
    final minutes = (secs ~/ 60).toString().padLeft(2, '0');
    final seconds = (secs % 60).toString().padLeft(2, '0');

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Moves: $moves"),
            Text("Pairs: $paro"),
            Text("Meta: ${baraja.length ~/ 2}"),
            // Muestra el cronómetro en formato mm:ss
            Text("Time: $minutes:$seconds"),
          ],
        ),
      ),
    );
  }
}
