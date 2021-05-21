import 'package:flutter/material.dart';

import '../../../components/gradient_button.dart';
import '../../../components/input_with_animation.dart';
import '../../../components/floating_button.dart';

class EditSurveys extends StatelessWidget {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

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
                  onPressed: () {
                  },
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
