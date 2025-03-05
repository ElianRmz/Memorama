import 'package:bottom_cupertino_tabbar/bottom_cupertino_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomC extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  /// Callback opcional para cuando se pulsa "Salir"
  final VoidCallback? onExit;

  const BottomC({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    this.onExit,
  }) : super(key: key);

  @override
  _BottomCState createState() => _BottomCState();
}

class _BottomCState extends State<BottomC> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: widget.selectedIndex,
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,

      // Hacemos asíncrono onTap para poder esperar la confirmación
      onTap: (int index) async {
        // Manejo de la pestaña "Salir" (índice 1)
        if (index == 1) {
          debugPrint("Botón Salir pulsado");

          // Primero mostramos el diálogo de confirmación
          final confirmacion = await _mensajeConfirmacion(
            context,
            "¿Desea regresar al inicio?",
          );

          // Si el usuario confirma:
          if (confirmacion) {
            // Llama a onExit si está definido
            if (widget.onExit != null) {
              widget.onExit!();
            }
            // Navega a 'home' y limpia el stack de navegación
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          }

          // Si no confirma, no hacemos nada (se queda en la misma pantalla)

        } else if (index == 2) {
          // Lógica para "Reiniciar"
          debugPrint("Botón Reiniciar pulsado");
          // TODO: Implementa tu acción para reiniciar

        } else if (index == 3) {
          // Lógica para "Juego nuevo"
          debugPrint("Botón Juego nuevo pulsado");
          // TODO: Implementa tu acción para juego nuevo

        } else {
          // Para cualquier otro índice (por ejemplo, 0 = "Game"),
          // delegamos a la lógica normal (widget.onTap)
          widget.onTap(index);
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_stack_3d_down_right),
          label: 'Game',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.eject),
          label: 'Salir',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.news),
          label: 'Reiniciar',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.car_detailed),
          label: 'Juego nuevo',
        ),
      ],
    );
  }

  /// Muestra un diálogo de confirmación con estilo Cupertino
  /// Retorna true si el usuario acepta, false en caso contrario.
  Future<bool> _mensajeConfirmacion(BuildContext context, String s) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Confirmación"),
          content: Text(s),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "Aceptar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
            CupertinoDialogAction(
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => Navigator.pop(context, false),
            )
          ],
        );
      },
    ) ?? false;
  }
}
