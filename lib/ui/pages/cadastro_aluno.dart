import 'package:flutter/material.dart';
import '../../datasources/local/local.dart';
import '../../model/model.dart';
import '../components/components.dart';
import 'pages.dart';

class CadastroAluno extends StatefulWidget {

  final Aluno? aluno;

  const CadastroAluno({this.aluno, Key? key}) : super(key: key);

  @override
  State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {

  final _formKey = GlobalKey<FormState>();
  final _alunoHelper = AlunoHelper();
  final _raController = TextEditingController();
  final _cpfController = TextEditingController();
  final _nomeController = TextEditingController();
  final _dtNascimentoController = TextEditingController();
  final _dtMatriculaController = TextEditingController();

  String? _dropValueCursos;
  String? _dropValuePeridos;

  final cursos = [
    "Análise e Desenv. Sistemas",
    "Administração",
    "Ciências Contábeis",
    "Direito",
    "Farmácia",
    "Nutrição"
  ];

  final periodos = [
    "1ª Série",
    "2ª Série",
    "3ª Série",
    "4ª Série",
    "5ª Série"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: _limparCampos,
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _salvarAluno,
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child:
                    BuildTextField(controller: _raController, left: 16, top: 16, right: 16,
                        type: TextInputType.name, labelText: 'RA', border: 6),
                  ),
                  Expanded(
                    flex: 3,
                    child: BuildTextField(controller: _cpfController, left: 0, top: 16, right: 16,
                        type: TextInputType.name, labelText: 'CPF', border: 6),
                  ),
                ],
              ),

              Column(
                children: [
                  BuildTextField(controller: _nomeController, left: 16, top: 16, right: 16,
                      type: TextInputType.name, labelText: 'Nome', border: 6),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                    BuildTextField(controller: _dtNascimentoController, left: 16, top: 16, right: 16,
                        type: TextInputType.name, labelText: 'Dt. Nascimento', border: 6),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    BuildTextField(controller: _dtMatriculaController, left: 0, top: 16, right: 16,
                        type: TextInputType.name, labelText: 'Dt. Matrícula', border: 6),
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => value == null ? "Selecione um item!" : null,
                      decoration: InputDecoration(
                        labelText: 'Curso',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      hint: const Text('Escolha um curso'),
                      value: _dropValueCursos,
                      isExpanded: true,
                      items: cursos.map(_buildMenuItem).toList(),
                      onChanged: (value) => setState(() => _dropValueCursos = value),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => value == null ? "Selecione um item!" : null,
                      decoration: InputDecoration(
                        labelText: 'Período',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      hint: const Text('Escolha um período'),
                      value: _dropValuePeridos,
                      isExpanded: true,
                      items: periodos.map(_buildMenuItem).toList(),
                      onChanged: (value) => setState(() => _dropValuePeridos = value),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  void _limparCampos() {
    _raController.text = "";
    _cpfController.text = "";
    _nomeController.text = "";
    _dtNascimentoController.text = "";
    _dtMatriculaController.text = "";
  }

  void _salvarAluno() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.aluno != null) {
      widget.aluno!.ra = _raController.text;
      widget.aluno!.cpf = _cpfController.text;
      widget.aluno!.nome = _nomeController.text;
      widget.aluno!.dtNascimento = _dtNascimentoController.text;
      widget.aluno!.dtMatricula = _dtMatriculaController.text;
      widget.aluno!.curso = _dropValueCursos.toString();
      widget.aluno!.periodo = _dropValuePeridos.toString();

      _alunoHelper.alterar(widget.aluno!);
    }
    else {
      _alunoHelper.inserir(Aluno(
          ra: _raController.text,
          cpf: _cpfController.text,
          nome: _nomeController.text,
          dtNascimento: _dtNascimentoController.text,
          dtMatricula: _dtMatriculaController.text,
          curso: _dropValueCursos.toString(),
          periodo: _dropValuePeridos.toString()
      ));
    }

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  const ListaAlunos()),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}
