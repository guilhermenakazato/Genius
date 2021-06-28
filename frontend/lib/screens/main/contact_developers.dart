import 'package:flutter/material.dart';

import '../../components/gradient_button.dart';
import '../../components/submit_file.dart';
import '../../components/input_with_animation.dart';
import '../../utils/application_colors.dart';

class ContactDevelopers extends StatelessWidget {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ApplicationColors.appBarColor,
          elevation: 0,
          title: Text(
            'Contatar desenvolvedores',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _subjectController,
                  type: TextInputType.name,
                  label: 'Assunto',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _messageController,
                  type: TextInputType.multiline,
                  label: 'Mensagem',
                  allowMultilines: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5.0),
                child: SubmitFile(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientButton(
                  onPressed: () {},
                  text: 'Enviar',
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
