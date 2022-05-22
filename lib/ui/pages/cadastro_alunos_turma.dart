import 'package:flutter/material.dart';

import '../../datasources/local/local.dart';
import '../../model/model.dart';
import '../components/components.dart';


class CadastroAlunosTurma extends StatefulWidget {

  final Turma? turma;

  const CadastroAlunosTurma({this.turma, Key? key}) : super(key: key);

  @override
  State<CadastroAlunosTurma> createState() => _CadastroAlunosTurmaState();
}

class _CadastroAlunosTurmaState extends State<CadastroAlunosTurma> {

  final _formKey = GlobalKey<FormState>();
  final _raController = TextEditingController();
  final _raAlunoController = TextEditingController();
  final _nomeAlunoController = TextEditingController();
  final _turmaHelper = TurmaHelper();
  final _alunoHelper = AlunoHelper();
  bool _isVisible = false;

  String? _dropValueTurmas;
  Aluno? _aluno;
  Turma? _turma;
  List<Aluno> a = [];

  List<String> turmas = [];

  _initDropDown() async {
    List<Turma> turma = await _turmaHelper.getAll();

    for (var i = 0; i < turma.length; i++) {
      setState(() {
        turmas.add(turma[i].codigoTurma);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Alunos na turma'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined, size: 30),
            onPressed: () {
               _cadastrarAlunoTurma();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: DropdownButtonFormField<String>(
              validator: (value) => value == null ? "Selecione um item!" : null,
              decoration: InputDecoration(
                labelText: 'Turma',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
              ),
              hint: const Text('Escolha uma turma'),
              value: _dropValueTurmas,
              isExpanded: true,
              items: turmas.map(_buildMenuItem).toList(),
              onChanged: (value) => setState(() => _dropValueTurmas = value),
            ),
          ),
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: BuildTextField(controller: _raController,
                      left: 16,
                      right: 16,
                      top: 16,
                      type: TextInputType.number,
                      labelText: 'Informe o RA',
                      border: 6),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.person_search, size: 60,
                          color: Color.fromRGBO(255, 0, 0, 1)),
                      onPressed: _buscaAluno,
                    )
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Column(
              children: [
                BuildTextField(isEnable: false, controller: _raAlunoController, left: 16, right: 16, top: 16, type: TextInputType.none,
                    labelText: 'RA', border: 6),
                BuildTextField(isEnable: false, controller: _nomeAlunoController, left: 16, right: 16, top: 16, type: TextInputType.none,
                    labelText: 'Nome', border: 6)
              ],
            )
          ),
        ],
      ),
    );
  }

  _cadastrarAlunoTurma() {
    MensagemAlerta.show(
      context: context,
      titulo: 'Atenção',
      texto: 'Deseja adicionar o aluno ${_aluno?.nome} na turma ${_dropValueTurmas.toString()}',
      botoes: [
        TextButton(
            child: const Text('Sim'),
            onPressed: () {
              _salva();
              Navigator.of(context).pop(true);
            }
        ),
        TextButton(
            child: const Text('Nao'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  _salva() async {
    _turma = await _turmaHelper.getTurma(_dropValueTurmas.toString());

    //
    //
    //
    //

    _turmaHelper.alterar(_turma!);

    setState(() {});
  }

  _buscaAluno() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _aluno = await _alunoHelper.getAluno(_raController.text.toString());

    if (_aluno == null) {
      MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Aluno não encontrado',
        botoes: [
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(true);
              }
          ),
        ],
      );

      _raController.text = "";
      return;
    }

    _raController.text = "";
    _isVisible = true;

    _raAlunoController.text = _aluno!.ra;
    _nomeAlunoController.text = _aluno!.nome;

    setState(() { });
  }
}
