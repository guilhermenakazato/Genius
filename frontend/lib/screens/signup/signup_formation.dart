import 'package:flutter/material.dart';

import '../../components/dropdown_button.dart';
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
  String _formation = 'Primeiro grau completo';
  final _items = <String>[
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
        },icon: Icons.arrow_forward_ios,
        text: 'Prosseguir',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownButton(
                items: _items,
                hint: 'Primeiro grau completo',
                width: 270,
                onValueChanged: (String newValue) {
                  _formation = newValue;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextScreen(BuildContext context) {
    widget.person.setFormation(_formation);
    _navigator.navigate(context, SignUpInstitution(widget.person));
  }
}
