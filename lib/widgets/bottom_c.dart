import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomC extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  /// Callback opcional para cuando se pulsa "Salir"
  final VoidCallback? onExit;

  /// Callback opcional para cuando se pulsa "Reiniciar"
  final VoidCallback? onReset;

  const BottomC({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    this.onExit,
    this.onReset,
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
      onTap: (int index) async {
        // Botón "Salir" (índice 1)
        if (index == 1) {
          final confirmacion = await _mensajeConfirmacion(
            context,
            "¿Desea regresar al inicio?",
          );
          if (confirmacion) {
            if (widget.onExit != null) {
              widget.onExit!();
            }
            Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
          }

          // Botón "Reiniciar" (índice 2)
        } else if (index == 2) {
          final confirmacion = await _mensajeConfirmacion(
            context,
            "¿Deseas reiniciar el juego?",
          );
          if (confirmacion) {
            // Llama a onReset si está definido
            if (widget.onReset != null) {
              widget.onReset!();
            }
            // NO hacemos Navigator.pop(context) aquí
            // para NO salir de Tablero
          }

          // Botón "Juego nuevo" (índice 3)
        } else if (index == 3) {
          final confirmacion = await _mensajeConfirmacion(
            context,
            "¿Deseas iniciar un juego nuevo?",
          );
          if (confirmacion) {
            if (widget.onReset != null) {
              widget.onReset!();
            }
            // TODO: Lógica para "Juego nuevo"
          }

        } else {
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

  Future<bool> _mensajeConfirmacion(BuildContext context, String s) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Confirmación"),
          content: Text(s),
          actions: [
            CupertinoDialogAction(
              child: const Text("Aceptar", style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.pop(context, true),
            ),
            CupertinoDialogAction(
              child: const Text("Cancelar", style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
