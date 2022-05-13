import 'package:flutter/material.dart';

import '../../datasources/local/local.dart';
import '../../model/model.dart';
import '../components/components.dart';
import 'pages.dart';

class CadastroTurma extends StatefulWidget {
  final Turma? turma;

  const CadastroTurma({this.turma, Key? key}) : super(key: key);

  @override
  State<CadastroTurma> createState() => _CadastroTurmaState();
}

class _CadastroTurmaState extends State<CadastroTurma> {

  String? _dropValueCursos;
  String? _dropValueTurno;
  String? _dropValueRegime;

  final _formKey = GlobalKey<FormState>();
  final _turmaHelper = TurmaHelper();
  final _codigoController = TextEditingController();

  final cursos = [
    "Análise e Desenv. Sistemas",
    "Administração",
    "Ciências Contábeis",
    "Direito",
    "Farmácia",
    "Nutrição"
  ];

  final turnos = [
    "Matutino",
    "Vespertino",
    "Noturno"
  ];

  final regimes = [
    "Semestral",
    "Anual",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.turma != null) {
      _codigoController.text = widget.turma!.codigoTurma;
      // _dropValueCursos.toString() = widget.turma!.curso;
      // _dropValueTurno.toString() = widget.turma!.turno;
      // _dropValueRegime.toString() = widget.turma!.regime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: _limparCampos,
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _salvarTurma,
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  BuildTextField(controller: _codigoController, left: 16, top: 16, right: 16,
                      type: TextInputType.name, labelText: 'Código', border: 6),

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
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: DropdownButtonFormField<String>(
                          validator: (value) => value == null ? "Selecione um item!" : null,
                          decoration: InputDecoration(
                            labelText: 'Turno',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)
                            ),
                          ),
                          hint: const Text('Escolha um turno'),
                          value: _dropValueTurno,
                          isExpanded: true,
                          items: turnos.map(_buildMenuItem).toList(),
                          onChanged: (value) => setState(() => _dropValueTurno = value),
                        ),
                      )
                  ),

                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: DropdownButtonFormField<String>(
                          validator: (value) => value == null ? "Selecione um item!" : null,
                          decoration: InputDecoration(
                            labelText: 'Regime',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)
                            ),
                          ),
                          hint: const Text('Escolha um regime'),
                          value: _dropValueRegime,
                          isExpanded: true,
                          items: regimes.map(_buildMenuItem).toList(),
                          onChanged: (value) => setState(() => _dropValueRegime = value),
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  void _limparCampos() {
    _codigoController.text = "";
  }

  void _salvarTurma() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.turma != null) {
      widget.turma!.codigoTurma = _codigoController.text;
      widget.turma!.curso = _dropValueCursos.toString();
      widget.turma!.turno = _dropValueTurno.toString();
      widget.turma!.regime = _dropValueRegime.toString();

      _turmaHelper.alterar(widget.turma!);
    }
    else {
      _turmaHelper.inserir(Turma(
        codigoTurma: _codigoController.text,
        curso: _dropValueCursos.toString(),
        turno: _dropValueTurno.toString(),
        regime: _dropValueRegime.toString(),
      ));
    }

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  const ListaTurmas()),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}