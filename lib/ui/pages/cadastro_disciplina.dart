import 'package:flutter/material.dart';

import '../../datasources/local/local.dart';
import '../../model/model.dart';
import '../components/components.dart';
import 'pages.dart';

class CadastroDisciplina extends StatefulWidget {

  final Disciplina? disciplina;

  const CadastroDisciplina({this.disciplina, Key? key}) : super(key: key);

  @override
  State<CadastroDisciplina> createState() => _CadastroDisciplinaState();
}

class _CadastroDisciplinaState extends State<CadastroDisciplina> {

  final _formKey = GlobalKey<FormState>();

  final _disciplinaHelper = DisciplinaHelper();
  ProfessorHelper _professorHelper = ProfessorHelper();

  final _codigoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _cargaHorariaController = TextEditingController();
  final _totDiasLetivosController = TextEditingController();

  String? _dropValueCursos;
  String? _dropValueprofessores;

  List<String> professores = [];

   _initDropDown() async {
     List<Professor> profs = await _professorHelper.getAll();

    for(var i = 0; i < profs.length; i++) {
      setState((){
        professores.add(profs[i].nome);
      });
    }
  }

  final cursos = [
    "Análise e Desenv. Sistemas",
    "Administração",
    "Ciências Contábeis",
    "Direito",
    "Farmácia",
    "Nutrição"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.disciplina != null) {
      _codigoController.text = widget.disciplina!.codigoDisciplina;
      _nomeController.text = widget.disciplina!.nome;
      // _dropValueprofessores.toString() = widget.disciplina!.professor;
      // _dropValueCursos.toString() = widget.disciplina!.curso;
      _cargaHorariaController.text = widget.disciplina!.cargaHoraria;
      _totDiasLetivosController.text = widget.disciplina!.totDiasLetivos;
    }

    _initDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Disciplina'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: _limparCampos,
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _salvarDisciplina,
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
                      type: TextInputType.number, labelText: 'Código', border: 6),

                  BuildTextField(controller: _nomeController, left: 16, top: 16, right: 16,
                      type: TextInputType.name, labelText: 'Nome', border: 6),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => value == null ? "Selecione um item!" : null,
                      decoration: InputDecoration(
                        labelText: 'Professor',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      hint: const Text('Escolha um professor'),
                      value: _dropValueprofessores,
                      isExpanded: true,
                      items: professores.map(_buildMenuItem).toList(),
                      onChanged: (value) => setState(() => _dropValueprofessores = value),
                    ),
                  ),

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
                    child:
                    BuildTextField(controller: _cargaHorariaController, left: 16, top: 16, right: 16,
                        type: TextInputType.number, labelText: 'Carga Horária', border: 6),
                  ),

                  Expanded(
                    flex: 1,
                    child: BuildTextField(controller: _totDiasLetivosController, left: 16, top: 16, right: 16,
                        type: TextInputType.number, labelText: 'Total D. Letivos', border: 6),
                  )
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
    _nomeController.text = "";
    _cargaHorariaController.text = "";
    _totDiasLetivosController.text = "";
  }

  void _salvarDisciplina() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.disciplina != null) {
      widget.disciplina!.codigoDisciplina = _codigoController.text;
      widget.disciplina!.nome = _nomeController.text;
      widget.disciplina!.professor = _dropValueprofessores.toString();
      widget.disciplina!.curso = _dropValueCursos.toString();
      widget.disciplina!.cargaHoraria = _cargaHorariaController.text;
      widget.disciplina!.totDiasLetivos = _totDiasLetivosController.text;

      _disciplinaHelper.alterar(widget.disciplina!);
    }
    else {
      _disciplinaHelper.inserir(Disciplina(
          codigoDisciplina: _codigoController.text,
          nome: _nomeController.text,
          professor: _dropValueprofessores.toString(),
          curso: _dropValueCursos.toString(),
          cargaHoraria: _cargaHorariaController.text,
          totDiasLetivos: _totDiasLetivosController.text,
      ));
    }

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  const ListaDisciplinas()),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}
