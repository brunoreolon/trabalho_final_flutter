import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/ui/pages/pages.dart';

import '../../datasources/local/local.dart';
import '../../model/model.dart';
import '../components/components.dart';

class ListaProfessores extends StatefulWidget {
  const ListaProfessores({Key? key}) : super(key: key);

  @override
  State<ListaProfessores> createState() => _ListaProfessoresState();
}

class _ListaProfessoresState extends State<ListaProfessores> {

  final _professorHelper = ProfessorHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Professores'),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_outlined, size: 30),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const CadastroProfessor())
                );
              },
            ),
          ],
        ),
      body: FutureBuilder(
        future: _professorHelper.getAll(),
        builder: (BuildContext context,  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Professor>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Professor> listaDados) {
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
              child: const Text('Editar Professor',
                style: TextStyle(color: Colors.white),),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text('Excluir Professor',
                style: TextStyle(color: Colors.white),),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(professor: listaDados[index]);
              }
              else if (direction == DismissDirection.endToStart) {
                _professorHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir este professor?',
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

  _criarItemLista(Professor professor) {
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
                      label: 'RA', valor: professor.ra,)
                ),
                Expanded(
                    flex: 3,
                    child: CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.right,
                      label: 'CPF', valor: professor.cpf,)
                )
              ],
            ),
            Row(
              children: [
                CustomText(8, 8, 0, 0, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                    label: 'Nome', valor: professor.nome)
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                      label: 'Matrícula', valor: professor.dtMatricula),
                ),
                Expanded(
                    flex: 1,
                    child: CustomText(8, 8, 0, 8, alignmentLabel: Alignment.topLeft, alignmentText: TextAlign.left,
                        label: 'Nascimento', valor: professor.dtNascimento)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _abrirTelaCadastro({Professor? professor}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastroProfessor(professor: professor)
    ));

    setState(() { });
  }
}
