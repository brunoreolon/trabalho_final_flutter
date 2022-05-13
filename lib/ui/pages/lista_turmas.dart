import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/model/model.dart';
import 'package:trabalho_final_flutter/ui/pages/pages.dart';

import '../../datasources/local/local.dart';
import '../components/components.dart';

class ListaTurmas extends StatefulWidget {
  const ListaTurmas({Key? key}) : super(key: key);

  @override
  State<ListaTurmas> createState() => _ListaTurmasState();
}

class _ListaTurmasState extends State<ListaTurmas> {

  final _turmaHelper = TurmaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CadastroTurma())
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _turmaHelper.getAll(),
        builder: (BuildContext context,  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Turma>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Turma> listaDados) {
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
              child: const Text('Editar Turma',
                style: TextStyle(color: Colors.white),),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text('Excluir Turma',
                style: TextStyle(color: Colors.white),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(turma: listaDados[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _turmaHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir esta turma?',
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

  _criarItemLista(Turma turma) {
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
                      label: 'Código', valor: turma.codigoTurma),

                CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'Curso', valor: turma.curso)
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CustomText(8,8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'Turno', valor: turma.turno)
                ),
                Expanded(
                    flex: 1,
                    child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'Regime', valor: turma.regime)
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _abrirTelaCadastro({Turma? turma}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastroTurma(turma: turma)
    ));

    setState(() { });
  }
}
