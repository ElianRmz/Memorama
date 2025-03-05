class Juego {

  int? id, victorias, derrotas;
  String? fecha;

  Juego(this.id, this.victorias, this.derrotas, this.fecha);

  Juego.deMap(Map<String, dynamic> map) {
    id = map["id"];
    victorias = map["victorias"];
    derrotas = map["derrotas"];
    fecha = map["fecha"];
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "victorias": victorias,
      "derrotas": derrotas,
      "fecha": fecha
    };
  }
}
