import 'package:flutter/material.dart';
import '../../../../utils/application_colors.dart';
import '../../../../components/checkbox_tile.dart';

import '../../../../components/dropdown_button.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';

class AchievementForm extends StatefulWidget {
  @override
  _AchievementFormState createState() => _AchievementFormState();
}

class _AchievementFormState extends State<AchievementForm> {
  final _typeOptions = <String>[
    'Medalha',
    'Certificado',
    'Honra ao mérito',
    'Outro'
  ];
  String _typeController = 'Medalha';
  final _institutionController = TextEditingController();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _customizedTypeController = TextEditingController();
  bool showPositionField = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationColors.appBarColor,
        elevation: 0,
        title: Text('Crie uma conquista'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
              child: DropDownButton(
                hint: 'Medalha',
                items: _typeOptions,
                width: 325,
                onValueChanged: (String value) {
                  _typeController = value;

                  setState(() {
                    _shouldShowCustomizedTypeField();
                    _shouldShowPositionQuestionField();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _nameController,
                type: TextInputType.multiline,
                label: 'Nome da conquista',
                allowMultilines: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _institutionController,
                type: TextInputType.name,
                label: 'Instituição da conquista',
              ),
            ),
            _shouldShowCustomizedTypeField(),
            _shouldShowPositionQuestionField(),
            _shouldShowPositionField(),
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
    );
  }

  Widget _shouldShowPositionQuestionField() {
    if (_typeController == 'Medalha' || _typeController == 'Outro') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 5.0, 16, 5),
        child: CheckboxTile(
          onChanged: (value) {
            showPositionField = value;

            setState(() {});
          },
          icon: Icons.military_tech,
          text: 'Quero colocar minha posição!',
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _shouldShowPositionField() {
    if (showPositionField) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
        child: InputWithAnimation(
          controller: _positionController,
          type: TextInputType.text,
          label: 'Posição conquistada',
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _shouldShowCustomizedTypeField() {
    if (_typeController == 'Outro') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
        child: InputWithAnimation(
          controller: _customizedTypeController,
          type: TextInputType.text,
          label: 'Tipo da conquista',
        ),
      );
    } else {
      return Container();
    }
  }
}