class Professor {
  static const tabela = 'TbProfessor';
  static const codigo_coluna = 'codigo';
  static const ra_coluna = 'ra';
  static const cpf_coluna = 'cpf';
  static const nome_coluna = 'nome';
  static const nascimento_coluna = 'dt_nascimento';
  static const matricula_coluna = 'dt_matricula';

  int? codigo;
  String ra;
  String cpf;
  String nome;
  String dtNascimento;
  String dtMatricula;

  Professor({
    this.codigo,
    required this.ra,
    required this.cpf,
    required this.nome,
    required this.dtNascimento,
    required this.dtMatricula,
  });

  factory Professor.fromMap(Map map) {
    return Professor(
        codigo: int.tryParse(map[codigo_coluna].toString()),
        ra: map[ra_coluna],
        cpf: map[cpf_coluna],
        nome: map[nome_coluna],
        dtNascimento: map[nascimento_coluna],
        dtMatricula: map[matricula_coluna],
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
    };
  }
}