import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 60),
            child: Text(
              'QUEM É GENIUS?',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 10, 35, 20),
            child: Text(
              '    Muito prazer, sou o Genius! Eu sou fascinado pela ciência e amo espalhar sobre suas conquistas pelo mundo.\n\n'
                  '    Por isso, fiz dessa a minha razão para viver, existo para fazer a ciência conhecida.\n\n'
                  '    Se você está aqui, sei que é porque tem interesse em conhecê-la ou somar em seu abrangente universo, então espero que goste desse ambiente e aproveite a passagem ❤ você não vai se arrepender!\n\n'
                  '    A ciência vale a pena.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                height: 1.3,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Divider(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 8),
            child: Text(
              'Equipe',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Equipe(nome: 'Gabriela Prado'),
          Equipe(nome: 'Guilherme Nakazato'),
          Equipe(nome: 'Sidney Sousa'),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
          ),
        ],
      ),
    );
  }
}

class Equipe extends StatelessWidget {
  final String nome;
  const Equipe({Key key, this.nome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        nome,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
