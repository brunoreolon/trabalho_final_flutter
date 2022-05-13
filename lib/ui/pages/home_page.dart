import 'package:flutter/material.dart';

import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _abrirTela(tela) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  tela),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.account_box_outlined, size: 30),
            Text('Trabalho Final', style: TextStyle(fontSize: 30)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _abrirTela(const Sobre());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              accountName: Text("Bruno Reolon"),
              accountEmail: Text("bruno.reolon@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://criticalhits.com.br/wp-content/uploads/2022/01/Screenshot-2022-01-15-at-15-06-08-itachi-uchiha-webp-WEBP-Image-1162-%C3%97-684-pixels.png'
                ),
              ),
            ),
            ExpansionTile(
              leading: const Icon(Icons.add_outlined),
              title: const Text('Cadastros'),
              children: [
                ListTile(
                  title: const Text('Aluno'),
                    onTap: () {
                      _abrirTela(const CadastroAluno());
                    }
                ),
                ListTile(
                  title: const Text('Professor'),
                    onTap: () {
                      _abrirTela(const CadastroProfessor());
                    }
                ),
                ListTile(
                  title: const Text('Disciplina'),
                    onTap: () {
                      _abrirTela(const CadastroDisciplina());
                    }
                ),
                ListTile(
                  title: const Text('Turma'),
                    onTap: () {
                      _abrirTela(const CadastroTurma());
                    }
                )
              ],
            ),
            const ExpansionTile(
              leading: Icon(Icons.assignment),
              title: Text('Lançamentos'),
              children: [
                ListTile(
                  title: Text('Notas'),
                  // onTap: ,
                ),
                ListTile(
                  title: Text('Frequências'),
                  // onTap: ,
                )
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.list_alt_rounded),
              title: const Text('Listar'),
              children: [
                ListTile(
                  title: const Text('Aluno'),
                  onTap: () {
                    _abrirTela(const ListaAlunos());
                  }
                ),
                 ListTile(
                  title: const Text('Professor'),
                  onTap: () {
                    _abrirTela(const ListaProfessores());
                  }
                ),
                ListTile(
                  title: const Text('Disciplina'),
                  onTap: () {
                    _abrirTela(const ListaDisciplinas());
                  }
                ),
                ListTile(
                  title: const Text('Turma'),
                  onTap: () {
                    _abrirTela(const ListaTurmas());
                  }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
