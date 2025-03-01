import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final VoidCallback? onExit;
  
  const Menu({Key? key, this.onExit}) : super(key: key);

  void _showCupertinoMenu(BuildContext context) {
    showCupertinoModalPopup(
      
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("Menú"),
        message: const Text("Selecciona una opción"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Reiniciar",style: TextStyle(color: Colors.blue),),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Consultar", style: TextStyle(color: Colors.blue)),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              // Call the onExit callback to cancel the timer
              if (onExit != null) {
                onExit!();
              }
              Navigator.pop(context); // Close the menu
              // Navigate to home screen using named route
              Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
            },
            child: const Text("Inicio", style: TextStyle(color: Colors.blue)),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: const Text("Cancelar"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.ellipsis), // Icono de menú
      onPressed: () => _showCupertinoMenu(context),
    );
  }
}
