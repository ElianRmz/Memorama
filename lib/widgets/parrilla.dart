import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../config/config.dart'; // Para Nivel y barajar()

class Parrilla extends StatefulWidget {
  final Nivel? nivel;

  final VoidCallback volt;

  final VoidCallback bonjorno;
  final VoidCallback fini;
  const Parrilla({
    Key? key,
    this.nivel,
    required this.volt,
    required this.bonjorno,
    required this.fini,
  }) : super(key: key);

  @override
  _ParrillaState createState() => _ParrillaState();
}

class _ParrillaState extends State<Parrilla> {
  int? prevclicked;
  bool? flag, habilitado, juan;
  bool volteon = true;

  @override
  void initState() {
    super.initState();
    controles = [];
    baraja = [];
    estados = [];
    barajar(widget.nivel!);

    prevclicked = -1;
    flag = false;
    habilitado = false;
    juan = true;

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        for (var control in controles) {
          control.toggleCard();
        }
        juan = false;
        volteon = false;
      });
      widget.fini();
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          habilitado = true;
        });
      });
    });
  }
  void resetGame() {
    setState(() {
      prevclicked = -1;
      flag = false;
      habilitado = false;
      juan = true;
      volteon = true;

      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          for (var control in controles) {
            if (control.state?.isFront == false) {
              control.toggleCard();
            }
          }
          juan = false;
          volteon = false;
        });
        widget.fini();
        Future.delayed(const Duration(seconds: 300), () {
          setState(() {
            habilitado = true;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        crossAxisCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(baraja.length, (index) {
          return FlipCard(
            controller: controles[index],
            onFlip: () {
              if (!volteon && (habilitado ?? false)) {
                // widget.volt();
              } else {
                return;
              }

              if (!flag!) {
                prevclicked = index;
                estados[index] = false;
              } else {
                setState(() {
                  habilitado = false;
                });
              }
              flag = !flag!;
              estados[index] = false;

              if (prevclicked != index && !flag!) {
                if (baraja.elementAt(index) == baraja.elementAt(prevclicked!)) {
                  debugPrint("clicked: Son iguales");
                  widget.bonjorno();
                  setState(() {
                    habilitado = true;
                  });
                } else {
                  widget.volt();
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      habilitado = false;
                    });
                    controles.elementAt(prevclicked!).toggleCard();
                    estados[prevclicked!] = true;
                    prevclicked = index;
                    controles.elementAt(index).toggleCard();
                    estados[index] = true;
                    setState(() {
                      habilitado = true;
                    });
                  });
                }
              } else {
                setState(() {
                  habilitado = true;
                });
              }
            },
            fill: Fill.fillBack,
            flipOnTouch: (habilitado ?? false) && !volteon ? estados[index] : false,
            front: Image.asset(baraja[index]),
            back: Image.asset("images/quest.png"),
          );
        }),
      ),
    );
  }
}