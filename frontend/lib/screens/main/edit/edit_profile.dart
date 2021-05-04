import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/user.dart';
import '../../../utils/application_colors.dart';
import '../../../components/picker.dart';
import '../../../components/gradient_button.dart';
import '../../../utils/application_typography.dart';
import '../../../components/dropdown_button.dart';
import '../../../components/input_with_animation.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key key, @required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _residencyController = TextEditingController(text: widget.user.local);
    _institutionController =
        TextEditingController(text: widget.user.institution);
    _typeController = widget.user.type;
    _ageController = int.parse(widget.user.age);
    _formationController = widget.user.formation;
  }

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _residencyController;
  TextEditingController _institutionController;
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
  int _ageController;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: ApplicationColors.splashColor,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Align(
            child: Column(
              children: <Widget>[
                _photoWidget(),
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
                            initialValue: int.parse(widget.user.age) - 10,
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
                    hint: widget.user.type,
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
                    hint: widget.user.formation,
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
                    onPressed: () {
                      _handleFormSubmit();
                    },
                    text: 'Salvar',
                    width: 270,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFormSubmit() {
    var username = _nameController.text;
    var email = _emailController.text;
    var type = _typeController;
    var age = _ageController.toString();
    var residency = _residencyController.text;
    var institution = _institutionController.text;
    var formation = _formationController;

    var person = User(
      username: username,
      email: email,
      type: type,
      age: age,
      local: residency,
      institution: institution,
      formation: formation,
    );
  }

  Widget _photoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/sem-foto.png'),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ApplicationColors.addPhotoColor,
              ),
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
