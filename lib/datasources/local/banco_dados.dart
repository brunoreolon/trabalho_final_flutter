import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalho_final_flutter/datasources/local/professor_helper.dart';

import 'local.dart';

class BancoDados {
  static const String _nomeBanco = 'trabalho_flutter.db';

  static final BancoDados _intancia = BancoDados.internal();
  factory BancoDados() => _intancia;
  BancoDados.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb, version: 1,
      onCreate: (Database db, int version) async {
            await db.execute(AlunoHelper.sqlCreate);
            await db.execute(ProfessorHelper.sqlCreate);
            await db.execute(DisciplinaHelper.sqlCreate);
            await db.execute(TurmaHelper.sqlCreate);
      }
    );
  }

  void close() async {
    Database meuDb = await db;
    meuDb.close();
  }
}