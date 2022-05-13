class Disciplina {
  static const tabela = 'TbDisciplina';
  static const codigo_coluna = 'codigo';
  static const codigo_disciplina_coluna = 'codigo_disciplina';
  static const nome_coluna = 'nome';
  static const professor_coluna = 'professor';
  static const curso_coluna = 'curso';
  static const carga_horaria_coluna = 'carga_horaria';
  static const tot_dias_letivos_coluna = 'tot_dias_letivos';

  int? codigo;
  String codigoDisciplina;
  String nome;
  String professor;
  String curso;
  String cargaHoraria;
  String totDiasLetivos;

  Disciplina({
    this.codigo,
    required this.codigoDisciplina,
    required this.nome,
    required this.professor,
    required this.curso,
    required this.cargaHoraria,
    required this.totDiasLetivos,
  });

  factory Disciplina.fromMap(Map map) {
    return Disciplina(
        codigo: int.tryParse(map[codigo_coluna].toString()),
        codigoDisciplina: map[codigo_disciplina_coluna],
        nome: map[nome_coluna],
        professor: map[professor_coluna],
        curso: map[curso_coluna],
        cargaHoraria: map[carga_horaria_coluna],
        totDiasLetivos: map[tot_dias_letivos_coluna]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_coluna: codigo,
      codigo_disciplina_coluna: codigoDisciplina,
      nome_coluna: nome,
      professor_coluna: professor,
      curso_coluna: curso,
      carga_horaria_coluna: cargaHoraria,
      tot_dias_letivos_coluna: totDiasLetivos,
    };
  }
}