import 'package:flutter/material.dart';

import '../../../../utils/application_colors.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';

class SurveyForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationColors.appBarColor,
        elevation: 0,
        title: Text('Crie um questionário'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
              child: InputWithAnimation(
                controller: _titleController,
                type: TextInputType.name,
                label: 'Título do questionário',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _urlController,
                type: TextInputType.multiline,
                label: 'Link do questionário',
                allowMultilines: true,
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
