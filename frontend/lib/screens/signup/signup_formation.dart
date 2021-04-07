import 'package:flutter/material.dart';

import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_institution.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpFormation extends StatefulWidget {
  final User person;

  SignUpFormation(this.person);

  @override
  _SignUpFormationState createState() => _SignUpFormationState();
}

class _SignUpFormationState extends State<SignUpFormation> {
  final _navigator = NavigatorUtil();
  String formation = 'Primeiro grau completo';
  final items = <String>[
    'Primeiro grau completo',
    'Primeiro grau incompleto',
    'Segundo grau completo',
    'Segundo grau incompleto',
    'Ensino profissional de nível técnico completo',
    'Ensino profissional de nível técnico incompleto',
    'Graduação completa',
    'Graduação incompleta',
    'Especialização completa',
    'Especialização incompleta',
    'Mestrado completo',
    'Mestrado incompleto',
    'Doutorado completo',
    'Doutorado incompleto'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingButton(
        onPressed: () {
          _nextScreen(context);
        },
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qual a sua\nformação acadêmica?',
              textAlign: TextAlign.center,
              style: ApplicationTypography.secondarySignUpText,
            ),
            DropdownButton<String>(
              value: formation,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: TextStyle(color: Theme.of(context).primaryColor),
              underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
              onChanged: (String newValue) {
                setState(() {
                  formation = newValue;
                });
              },
              items: items
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _nextScreen(BuildContext context) {
    widget.person.setFormation(formation);
    _navigator.navigate(context, SignUpInstitution(widget.person));
  }
}
