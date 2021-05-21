import 'package:flutter/material.dart';

import '../../../components/gradient_button.dart';
import '../../../components/input_with_animation.dart';
import '../../../components/dropdown_button.dart';
import '../../../components/floating_button.dart';

// TODO: adicionar mais condições
class EditConquistas extends StatefulWidget {
  @override
  _EditConquistasState createState() => _EditConquistasState();
}

class _EditConquistasState extends State<EditConquistas> {
  String _typeController = 'Medalha';
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _institutionController = TextEditingController();
  final _customizedTypeController = TextEditingController();
  final _typeOptions = <String>[
    'Medalha',
    'Certificado',
    'Honra ao mérito',
    'Outro'
  ];

  bool showPositionField = false;
  bool showCustomizedTypeField = false;

  @override
  void initState() {
    _shouldShowPositionField();
    _shouldShowCustomizedTypeField();
    super.initState();
  }

  void _shouldShowPositionField() {
    if (_typeController == 'Medalha') {
      showPositionField = true;
    } else {
      showPositionField = false;
    }
  }

  void _shouldShowCustomizedTypeField() {
    if (_typeController == 'Outro') {
      showCustomizedTypeField = true;
    } else {
      showCustomizedTypeField = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        onPressed: () {},
        icon: Icons.add,
        text: 'Adicionar',
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
                    _shouldShowPositionField();
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
            if (showPositionField)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _positionController,
                  type: TextInputType.text,
                  label: 'Posição conquistada',
                ),
              ),
            if(showCustomizedTypeField)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _customizedTypeController,
                type: TextInputType.text,
                label: 'Tipo customizado',
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
    );
  }
}
