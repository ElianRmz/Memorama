import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/config/config.dart';

class Menu extends StatelessWidget {
  final VoidCallback? onExit;

  final Nivel? nivel; // Esto se usa para sabar en que nivel se encuentra
  final VoidCallback? onReset;

  const Menu({
    Key? key,
    this.onExit,
    this.nivel,
    this.onReset,
  }) : super(key: key);
  void _showCupertinoMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("Menú"),
        message: const Text("Selecciona una opción"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              if (await _mensajeConfirmacion(context, "¿Deseas reiniciar el juego?")) if (onReset != null) onReset!();
            },
            child: const Text(
              "Reiniciar",
              style: TextStyle(color: Colors.blue),
            ),
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
  Future<bool> _mensajeConfirmacion(BuildContext context, String s) async {
    return await showDialog(
        context: context,
        // barrierDismissible: false,
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
                  onPressed: () => Navigator.pop(context, true)),
              CupertinoDialogAction(
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () => Navigator.pop(context, false),
              )
            ],
          );
        }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.ellipsis), // Icono de menú
      onPressed: () => _showCupertinoMenu(context),
    );
  }
}