import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as iguana;
import 'package:path/path.dart';
import 'juego.dart';

class Sqlite {
  static Future<iguana.Database> db() async {
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    String ruta = join(appDocumentsDir.path, "databases", "Juego.db");
    return iguana.openDatabase(
      ruta,
      version: 1,
      singleInstance: true,
      onCreate: (db, version) async {
        await createDb(db);
      },
    );
  }

  static Future<void> createDb(iguana.Database db) async {
    const String sql = """
        create table Juego (
        id integer primary key autoincrement not null,
        victorias integer not null,
        derrotas integer not null,
        fecha text not null
        )
       """;

    await db.execute(sql);
  } //end createDb

  static Future<List<Juego>> consulta() async {
    final iguana.Database db = await Sqlite.db(); //abrir base
    final List<Map<String, dynamic>> query = await db.query("Juego");
    return query.map(
      (e) {
        return Juego.deMap(e);
      },
    ).toList();
  }

  static Future<int> add(List<Juego> planets) async {
    final iguana.Database db = await Sqlite.db(); //abrir base
    int? error;
    for (Juego p in planets) {
      error = await db.insert("Juego", p.toMap(),
          conflictAlgorithm: iguana.ConflictAlgorithm.replace);
    }
    db.close();
    return error!;
  }

  static Future<void> del(int i) async {
    final iguana.Database db = await Sqlite.db(); //abrir base

    await db.delete("Juego", where: "id =?", whereArgs: [i]);
  }
}//end class















