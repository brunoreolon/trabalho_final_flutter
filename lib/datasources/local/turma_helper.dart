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
      ${Turma.regime_coluna} TEXT,
      ${Turma.id_aluno_coluna} INTEGER,
      ${Turma.id_disciplina_coluna} INTEGER,
      FOREIGN KEY(${Turma.id_aluno_coluna}) REFERENCES TbAluno(codigo),
      FOREIGN KEY(${Turma.id_disciplina_coluna}) REFERENCES TbDisciplina(codigo)
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
        Turma.tabela,
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

  Future<Turma?> getTurma(String codigoTurma) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
        Turma.tabela,
        where: '${Turma.codigo_turma_coluna} = ?',
        whereArgs: [codigoTurma]
    );

    return Turma.fromMap(dados.first);
  }

  Future<List<Turma>> getAll() async {
    Database db = await BancoDados().db;

    List dados = await db.query(Turma.tabela);

    return dados.map((e) => Turma.fromMap(e)).toList();
  }
}