import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

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
              Navigator.pop(context);
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
