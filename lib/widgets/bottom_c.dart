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
      onTap: (int index) {
        // Si se pulsa la pestaña 1 ("Salir")
        if (index == 1) {
          debugPrint("Botón Salir pulsado");

          // Llama a onExit (si está definido)
          if (widget.onExit != null) {
            widget.onExit!();
          }

          // Cierra la pantalla actual (si hay un Navigator)
          Navigator.pop(context);

          // Navega a la ruta 'home' y elimina el stack de navegación
          Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
        } else {
          // Para las demás pestañas, llamamos a onTap para la lógica normal
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
}
