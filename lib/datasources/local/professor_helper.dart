import '../../model/model.dart';
import 'package:sqflite/sqflite.dart';

import 'local.dart';

class ProfessorHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Professor.tabela} (
      ${Professor.codigo_coluna} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Professor.ra_coluna} TEXT,
      ${Professor.cpf_coluna} TEXT,
      ${Professor.nome_coluna} TEXT,
      ${Professor.nascimento_coluna} TEXT,
      ${Professor.matricula_coluna} TEXT
    )
  ''';

  Future<Professor> inserir(Professor professor) async {
    Database db = await BancoDados().db;

    professor.codigo = await db.insert(Professor.tabela, professor.toMap());
    return professor;
  }

  Future<int> alterar(Professor professor) async {
    Database db = await BancoDados().db;

    return db.update(
        Professor.tabela,
        professor.toMap(),
        where: '${Professor.ra_coluna} = ?',
        whereArgs: [professor.ra]
    );
  }

  Future<int> apagar(Professor professor) async {
    Database db = await BancoDados().db;

    return await db.delete(Professor.tabela,
        where: '${Professor.ra_coluna} = ?',
        whereArgs: [professor.ra]
    );
  }

  Future<Professor?> getProfessor(int raProfessor) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
        Professor.tabela,
        where: '${Professor.ra_coluna} = ?',
        whereArgs: [raProfessor]
    );

    return Professor.fromMap(dados.first);
  }

  Future<List<Professor>> getAll() async {
    Database db = await BancoDados().db;

    List dados = await db.query(Professor.tabela);

    return dados.map((e) => Professor.fromMap(e)).toList();
  }
}