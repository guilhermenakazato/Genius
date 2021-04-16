import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/picker.dart';
import '../../../components/gradient_button.dart';
import '../../../utils/application_typography.dart';
import '../../../components/dropdown_button.dart';
import '../../../components/input_with_animation.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _residencyController = TextEditingController();
  final _institutionController = TextEditingController();
  final _typeOptions = <String>['Estudante', 'Professor'];
  final _formationOptions = <String>[
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

  String _typeController;
  String _formationController;
  int _ageController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  
                  children: <Widget>[
                    Positioned(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/sem-foto.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
                child: InputWithAnimation(
                  controller: _nameController,
                  type: TextInputType.name,
                  label: 'Nome completo',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Container(
                  height: 95,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Idade:',
                          style: ApplicationTypography.specialAgeInput,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Picker(
                          onChanged: (int value) {
                            _ageController = value + 10;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _residencyController,
                  type: TextInputType.streetAddress,
                  label: 'Moradia',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _institutionController,
                  type: TextInputType.streetAddress,
                  label: 'Instituição',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: DropDownButton(
                  hint: 'Professor',
                  items: _typeOptions,
                  width: 325,
                  onValueChanged: (String value) {
                    _typeController = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: DropDownButton(
                  hint: 'Primeiro grau completo',
                  items: _formationOptions,
                  width: 325,
                  onValueChanged: (String value) {
                    _formationController = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientButton(
                  onPressed: () {},
                  text: 'Salvar',
                  width: 270,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
