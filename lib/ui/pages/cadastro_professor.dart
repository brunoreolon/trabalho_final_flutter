import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/local.dart';
import '../../model/model.dart';

import '../components/components.dart';
import 'pages.dart';

class CadastroProfessor extends StatefulWidget {
  final Professor? professor;

  const CadastroProfessor({this.professor, Key? key}) : super(key: key);

  @override
  State<CadastroProfessor> createState() => _CadastroProfessorState();
}

class _CadastroProfessorState extends State<CadastroProfessor> {

  final _formKey = GlobalKey<FormState>();
  final _professorHelper = ProfessorHelper();
  final _raController = TextEditingController();
  final _cpfController = TextEditingController();
  final _nomeController = TextEditingController();
  final _dtNascimentoController = TextEditingController();
  final _dtMatriculaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      _raController.text = widget.professor!.ra;
      _cpfController.text = widget.professor!.cpf;
      _nomeController.text = widget.professor!.nome;
      _dtNascimentoController.text = widget.professor!.dtNascimento;
      _dtMatriculaController.text = widget.professor!.dtMatricula;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Professor'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: _limparCampos,
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _salvarProfessor,
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
                        type: TextInputType.number, labelText: 'RA', border: 6),
                  ),
                  Expanded(
                    flex: 3,
                    child: BuildTextField(controller: _cpfController, left: 16, top: 16, right: 16,
                        type: TextInputType.number, labelText: 'CPF', border: 6),
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
                        type: TextInputType.number, labelText: 'Dt. Nascimento', border: 6),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    BuildTextField(controller: _dtMatriculaController, left: 0, top: 16, right: 16,
                        type: TextInputType.number, labelText: 'Dt. Matrícula', border: 6),
                  ),
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

  void _salvarProfessor() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.professor != null) {
      widget.professor!.ra = _raController.text;
      widget.professor!.cpf = _cpfController.text;
      widget.professor!.nome = _nomeController.text;
      widget.professor!.dtNascimento = _dtNascimentoController.text;
      widget.professor!.dtMatricula = _dtMatriculaController.text;

      _professorHelper.alterar(widget.professor!);
    }
    else {
      _professorHelper.inserir(Professor(
          ra: _raController.text,
          cpf: _cpfController.text,
          nome: _nomeController.text,
          dtNascimento: _dtNascimentoController.text,
          dtMatricula: _dtMatriculaController.text,
      ));
    }
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  const ListaProfessores()),
    );
  }
}
