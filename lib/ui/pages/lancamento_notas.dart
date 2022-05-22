import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/model/model.dart';
import 'package:trabalho_final_flutter/ui/components/components.dart';

import '../../datasources/local/local.dart';

class LancamentoNotas extends StatefulWidget {
  const LancamentoNotas({Key? key}) : super(key: key);

  @override
  State<LancamentoNotas> createState() => _LancamentoNotasState();
}

class _LancamentoNotasState extends State<LancamentoNotas> {

  final _formKey = GlobalKey<FormState>();
  final _disciplinaHelper = DisciplinaHelper();
  final _alunoHelper = AlunoHelper();
  final _raController = TextEditingController();
  final _nota1Controller = TextEditingController();
  final _nota2Controller = TextEditingController();
  final _raAlunoController = TextEditingController();
  final _nomeAlunoController = TextEditingController();

  bool _isVisible = false;
  Aluno? _aluno;

  String? _dropValueCursos;
  String? _dropValueDisciplinas;

  List<String> disciplinas = [];
  List<Disciplina> disci = [];
  List<String> curso = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Lançamento de Notas'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: BuildTextField(controller: _raController, left: 16, right: 16, top: 16,
                        type: TextInputType.number, labelText: 'Informe o RA', border: 6),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.person_search, size: 60,  color: Color.fromRGBO(255, 0, 0, 1)),
                      onPressed: _buscaAluno,
                    )
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Visibility(
                  visible: _isVisible,
                  child: Column(
                      children: [
                        BuildTextField(isEnable: false, controller: _raAlunoController, left: 16, right: 16, top: 16, type: TextInputType.none,
                            labelText: 'RA', border: 6),
                        BuildTextField(isEnable: false, controller: _nomeAlunoController, left: 16, right: 16, top: 16, type: TextInputType.none,
                            labelText: 'Nome', border: 6)
                      ]
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'Curso',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    // hint: const Text('Escolha um curso'),
                    value: _dropValueCursos,
                    isExpanded: true,
                    items: curso.map(_buildMenuItem).toList(),
                    onChanged: (value) => setState(() => _dropValueCursos = value),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: DropdownButtonFormField<String>(
                    validator: (value) => value == null ? "Selecione um item!" : null,
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: 'Disciplina',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    // hint: const Text('Escolha uma disciplina'),
                    value: _dropValueDisciplinas,
                    isExpanded: true,
                    items: disciplinas.map(_buildMenuItem).toList(),
                    onChanged: (value) => setState(() => _dropValueDisciplinas = value),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: BuildTextField(controller: _nota1Controller, left: 16, right: 16, top: 16,
                      type: TextInputType.number, labelText: '1ª Nota', border: 6),
                ),
                Visibility(
                  visible: true,
                    child: Expanded(
                      flex: 1,
                      child: BuildTextField(controller: _nota2Controller, left: 0, right: 16, top: 16,
                          type: TextInputType.number, labelText: '2ª Nota', border: 6),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item),
  );

  _buscaAluno() async{
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
                onPressed: (){ Navigator.of(context).pop(true); }
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

    _loadDropDown();

  }

  _loadDropDown() async {
    curso.add(await _aluno!.curso);

    _dropValueCursos = curso[0];

    if (curso.length > 1) {
      curso.removeAt(0);
      _dropValueCursos = curso[0];
    }

    disci = await _disciplinaHelper.getDisciplinasCurso(_dropValueCursos.toString());

    for(var i = 0; i < disci.length; i++) {
      setState((){
        disciplinas.add(disci[i].nome);
      });
    }

    setState(() {  });
  }
}
