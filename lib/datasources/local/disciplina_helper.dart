import 'package:sqflite/sqflite.dart';

import '../../model/model.dart';
import 'local.dart';

class DisciplinaHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Disciplina.tabela} (
      ${Disciplina.codigo_coluna} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Disciplina.codigo_disciplina_coluna} TEXT,
      ${Disciplina.nome_coluna} TEXT,
      ${Disciplina.professor_coluna} TEXT,
      ${Disciplina.curso_coluna} TEXT,
      ${Disciplina.carga_horaria_coluna} TEXT,
      ${Disciplina.tot_dias_letivos_coluna} TEXT
    )
  ''';

  Future<Disciplina> inserir(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    disciplina.codigo = await db.insert(Disciplina.tabela, disciplina.toMap());
    return disciplina;
  }

  Future<int> alterar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return db.update(
        Disciplina.tabela,
        disciplina.toMap(),
        where: '${Disciplina.codigo_disciplina_coluna} = ?',
        whereArgs: [disciplina.codigoDisciplina]
    );
  }

  Future<int> apagar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return await db.delete(Disciplina.tabela,
        where: '${Disciplina.codigo_disciplina_coluna} = ?',
        whereArgs: [disciplina.codigoDisciplina]
    );
  }

  Future<Disciplina?> getDisciplina(int raDisciplina) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
        Disciplina.tabela,
        where: '${Disciplina.codigo_disciplina_coluna} = ?',
        whereArgs: [raDisciplina]
    );

    return Disciplina.fromMap(dados.first);
  }

  Future<List<Disciplina>> getAll() async {
    Database db = await BancoDados().db;

    List dados = await db.query(Disciplina.tabela);

    return dados.map((e) => Disciplina.fromMap(e)).toList();
  }
}