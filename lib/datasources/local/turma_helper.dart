import '../../model/model.dart';
import 'package:sqflite/sqflite.dart';

import 'local.dart';

class TurmaHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Turma.tabela} (
      ${Turma.codigo_coluna} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Turma.codigo_turma_coluna} TEXT,
      ${Turma.curso_coluna} TEXT,
      ${Turma.turno_coluna} TEXT,
      ${Turma.regime_coluna} TEXT
    )
  ''';

  Future<Turma> inserir(Turma turma) async {
    Database db = await BancoDados().db;

    turma.codigo = await db.insert(Turma.tabela, turma.toMap());
    return turma;
  }

  Future<int> alterar(Turma turma) async {
    Database db = await BancoDados().db;

    return db.update(
        Professor.tabela,
        turma.toMap(),
        where: '${Turma.codigo_turma_coluna} = ?',
        whereArgs: [turma.codigoTurma]
    );
  }

  Future<int> apagar(Turma turma) async {
    Database db = await BancoDados().db;

    return await db.delete(Turma.tabela,
        where: '${Turma.codigo_turma_coluna} = ?',
        whereArgs: [turma.codigoTurma]
    );
  }

  Future<Turma?> getTurma(int raTurma) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
        Professor.tabela,
        where: '${Turma.codigo_turma_coluna} = ?',
        whereArgs: [raTurma]
    );

    return Turma.fromMap(dados.first);
  }

  Future<List<Turma>> getAll() async {
    Database db = await BancoDados().db;

    List dados = await db.query(Turma.tabela);

    return dados.map((e) => Turma.fromMap(e)).toList();
  }
}