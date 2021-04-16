import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/application_typography.dart';
import '../../../components/dropdown_button.dart';
import '../../../components/input_with_animation.dart';

class EditProfile extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _residencyController = TextEditingController();
  final _institutionController = TextEditingController();
  final _optionsController = 'Professor';
  final _options = <String>['Estudante', 'Professor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/sem-foto.png'),
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
                  height: 62,
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
                          'Idade',
                          style: ApplicationTypography.specialAgeInput,
                        ),
                      )
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
              DropDownButton(
                initialValue: _optionsController,
                items: _options,
                width: 325,
              ),
              DropDownButton(
                initialValue: _optionsController,
                items: _options,
                width: 325,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
