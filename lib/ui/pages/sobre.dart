import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Sobre'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Alunos', style:  TextStyle(fontSize: 30)),
            Text('Bruno Neres Reolon'),
            Text('Gabriel Sementino')
          ],
        ),
      ),
    );
  }
}
