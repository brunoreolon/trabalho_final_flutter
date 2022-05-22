import '../../model/model.dart';
import 'package:sqflite/sqflite.dart';

import 'local.dart';

class AlunoHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Aluno.tabela} (
      ${Aluno.codigo_coluna} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Aluno.ra_coluna} TEXT,
      ${Aluno.cpf_coluna} TEXT,
      ${Aluno.nome_coluna} TEXT,
      ${Aluno.nascimento_coluna} TEXT,
      ${Aluno.matricula_coluna} TEXT,
      ${Aluno.curso_coluna} TEXT,
      ${Aluno.periodo_coluna} TEXT
    )
  ''';

  Future<Aluno> inserir(Aluno aluno) async {
    Database db = await BancoDados().db;

    aluno.codigo = await db.insert(Aluno.tabela, aluno.toMap());
    return aluno;
  }

  Future<int> alterar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return db.update(
        Aluno.tabela,
        aluno.toMap(),
        where: '${Aluno.ra_coluna} = ?',
        whereArgs: [aluno.ra]
    );
  }

  Future<int> apagar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return await db.delete(Aluno.tabela,
        where: '${Aluno.ra_coluna} = ?',
        whereArgs: [aluno.ra]
    );
  }

  Future<Aluno?> getAluno(String raAluno) async {
    Database db = await BancoDados().db;

    try {
      List dados = await db.query(
          Aluno.tabela,
          where: '${Aluno.ra_coluna} = ?',
          whereArgs: [raAluno]
      );
      return Aluno.fromMap(dados.first);
    } catch(e) {
      return null;
    }
  }

  Future<List<Aluno>> getAll() async {
    Database db = await BancoDados().db;

    List dados = await db.query(Aluno.tabela);

    return dados.map((e) => Aluno.fromMap(e)).toList();
  }
}