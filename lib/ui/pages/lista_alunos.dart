import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';
import 'package:trabalho_final_flutter/ui/pages/pages.dart';

import '../../model/model.dart';
import '../components/components.dart';

class ListaAlunos extends StatefulWidget {
  const ListaAlunos({Key? key}) : super(key: key);

  @override
  State<ListaAlunos> createState() => _ListaAlunosState();
}

class _ListaAlunosState extends State<ListaAlunos> {
  final _alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CadastroAluno())
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _alunoHelper.getAll(),
        builder: (BuildContext context,  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Aluno>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Aluno> listaDados) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(listaDados[index]),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Text('Editar Aluno',
                style: TextStyle(color: Colors.white),),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text('Excluir Aluno',
                style: TextStyle(color: Colors.white),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(aluno: listaDados[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _alunoHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este aluno?',
                    botoes: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: (){ Navigator.of(context).pop(true); }
                      ),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: (){ Navigator.of(context).pop(false); }
                      ),
                    ]);
              }
              return true;
            },
          );
        }
    );
  }

  _criarItemLista(Aluno aluno) {
    return GestureDetector(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: CustomText(8,8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'RA', valor: aluno.ra,)
                ),
                Expanded(
                    flex: 3,
                    child: CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'CPF', valor: aluno.cpf,)
                )
              ],
            ),
            Row(
              children: [
                CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                    label: 'Nome', valor: aluno.nome)
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Nascimento', valor: aluno.dtNascimento),
                ),
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Matrícula', valor: aluno.dtMatricula)
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Curso', valor: aluno.curso),
                ),
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Período', valor: aluno.periodo),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _abrirTelaCadastro({Aluno? aluno}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastroAluno(aluno: aluno)
    ));

    setState(() { });
  }
}

