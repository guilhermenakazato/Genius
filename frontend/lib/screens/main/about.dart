import 'package:flutter/material.dart';

import '../../utils/application_typography.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'QUEM É GENIUS?',
                  style: ApplicationTypography.aboutTitle,
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
                style: ApplicationTypography.aboutText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Center(
                child: Text(
                  'EQUIPE',
                  style: ApplicationTypography.teamMembersTitle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 84,
                runSpacing: 10,
                children: <Widget>[
                  _Team(
                    name: 'Gabriela\nPrado',
                    photoPath: 'assets/gabi.jpeg',
                  ),
                  _Team(
                    name: 'Guilherme\nNakazato',
                    photoPath: 'assets/sem-foto.png',
                  ),
                  _Team(
                    name: 'Sidney\nSousa',
                    photoPath: 'assets/sidney.jpeg',
                  ),
                  _Team(
                    name: 'NUDES',
                    photoPath: 'assets/nudes.jpeg',
                  ),
                  _Team(
                    name: 'IFMS\nCampus\nAquidauana',
                    photoPath: 'assets/ifms.png',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Team extends StatelessWidget {
  final String name;
  final String photoPath;
  const _Team({
    Key key,
    @required this.name,
    @required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(photoPath),
          ),
        ),
        Text(
          name,
          style: ApplicationTypography.aboutTeam,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
