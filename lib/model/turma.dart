import 'model.dart';

class Turma {
  static const tabela = 'TbTurma';
  static const codigo_coluna = 'codigo';
  static const codigo_turma_coluna = 'codigoTurma';
  static const curso_coluna = 'curso';
  static const turno_coluna = 'turno';
  static const regime_coluna = 'regime';
  static const id_aluno_coluna = 'idAluno';
  static const id_disciplina_coluna = 'idDisciplina';

  int? codigo;
  String codigoTurma;
  String curso;
  String turno;
  String regime;
  List<Aluno>? alunos = [];
  List<Disciplina>? disciplinas = [];

  Turma({
      this.codigo,
      this.alunos,
      this.disciplinas,
      required this.codigoTurma,
      required this.curso,
      required this.turno,
      required this.regime,
  });

  factory Turma.fromMap(Map map) {
    return Turma(
      codigo: int.tryParse(map[codigo_coluna].toString()),
      codigoTurma: map[codigo_turma_coluna],
      curso: map[curso_coluna],
      turno: map[turno_coluna],
      regime: map[regime_coluna],
      alunos:  map[id_aluno_coluna],
      disciplinas: map[id_disciplina_coluna],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_coluna: codigo,
      codigo_turma_coluna: codigoTurma,
      curso_coluna: curso,
      turno_coluna: turno,
      regime_coluna: regime,
      id_aluno_coluna: alunos,
      id_disciplina_coluna: disciplinas,
    };
  }
}