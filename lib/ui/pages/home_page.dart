import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _abrirCadastroAluno() {

  }

  void _abrirCadastroProfessor() {}

  void _abrirCadastroDisciplina() {}

  void _abrirCadastroTurma() {}

  void _abrirSobre() {}

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
            onPressed: _abrirSobre,
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
              leading: Icon(Icons.add_outlined),
              title: Text('Cadastros'),
              children: [
                ListTile(
                  title: Text('Aluno'),
                  onTap: _abrirCadastroAluno,
                ),
                ListTile(
                  title: Text('Professor'),
                  onTap: _abrirCadastroProfessor,
                ),
                ListTile(
                  title: Text('Disciplina'),
                  onTap: _abrirCadastroDisciplina,
                ),
                ListTile(
                  title: Text('Turma'),
                  onTap: _abrirCadastroTurma,
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
            const ExpansionTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('Listar'),
              children: [
                ListTile(
                  title: Text('Aluno'),
                  // onTap: ,
                ),
                ListTile(
                  title: Text('Professor'),
                  // onTap: ,
                ),
                ListTile(
                  title: Text('Disciplina'),
                  // onTap: ,
                ),
                ListTile(
                  title: Text('Turma'),
                  // onTap: ,
                )
              ],
            ),
          ],
        ),
      ),
      // body: ,
    );
  }
}
