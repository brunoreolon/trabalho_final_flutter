class Aluno {
  static const tabela = 'TbAluno';
  static const codigo_coluna = 'codigo';
  static const ra_coluna = 'ra';
  static const cpf_coluna = 'cpf';
  static const nome_coluna = 'nome';
  static const nascimento_coluna = 'dt_nascimento';
  static const matricula_coluna = 'dt_matricula';
  static const curso_coluna = 'curso';
  static const periodo_coluna = 'periodo';

  int? codigo;
  String ra;
  String cpf;
  String nome;
  String dtNascimento;
  String dtMatricula;
  String curso;
  String periodo;


  Aluno({
    this.codigo,
    required this.ra,
    required this.cpf,
    required this.nome,
    required this.dtNascimento,
    required this.dtMatricula,
    required this.curso,
    required this.periodo
  });

  factory Aluno.fromMap(Map map) {
    return Aluno(
        codigo: int.tryParse(map[codigo_coluna].toString()),
        ra: map[ra_coluna],
        cpf: map[cpf_coluna],
        nome: map[nome_coluna],
        dtNascimento: map[nascimento_coluna],
        dtMatricula: map[matricula_coluna],
        curso: map[curso_coluna],
        periodo: map[periodo_coluna]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_coluna: codigo,
      ra_coluna: ra,
      cpf_coluna: cpf,
      nome_coluna: nome,
      nascimento_coluna: dtNascimento,
      matricula_coluna: dtMatricula,
      curso_coluna: curso,
      periodo_coluna: periodo,
    };
  }
}