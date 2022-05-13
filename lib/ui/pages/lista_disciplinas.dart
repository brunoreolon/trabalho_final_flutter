import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/local.dart';
import 'package:trabalho_final_flutter/model/model.dart';
import 'package:trabalho_final_flutter/ui/pages/pages.dart';

import '../components/components.dart';

class ListaDisciplinas extends StatefulWidget {
  const ListaDisciplinas({Key? key}) : super(key: key);

  @override
  State<ListaDisciplinas> createState() => _ListaDisciplinasState();
}

class _ListaDisciplinasState extends State<ListaDisciplinas> {

  final _disciplinaHelper = DisciplinaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CadastroDisciplina())
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _disciplinaHelper.getAll(),
        builder: (BuildContext context,  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Disciplina>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Disciplina> listaDados) {
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
              child: const Text('Editar Disciplina',
                style: TextStyle(color: Colors.white),),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text('Excluir Disciplina',
                style: TextStyle(color: Colors.white),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(disciplina: listaDados[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _disciplinaHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir esta disciplina?',
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

  _criarItemLista(Disciplina disciplina) {
    return GestureDetector(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Column(
              children: [
                CustomText(8,8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                    label: 'Código', valor: disciplina.codigoDisciplina),

                CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                    label: 'Nome', valor: disciplina.nome),

                CustomText(8,8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                    label: 'Professor', valor: disciplina.professor),

                CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                    label: 'Curso', valor: disciplina.curso)
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Carga Horária', valor: disciplina.cargaHoraria),
                ),
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Total D. Letivos', valor: disciplina.totDiasLetivos),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _abrirTelaCadastro({Disciplina? disciplina}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastroDisciplina(disciplina: disciplina)
    ));

    setState(() { });
  }
}
