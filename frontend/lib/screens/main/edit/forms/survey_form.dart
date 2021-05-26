import 'package:flutter/material.dart';

import '../../../../models/survey.dart';
import '../../../../utils/application_colors.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';

class SurveyForm extends StatefulWidget {
  final String type;
  final Survey survey;

  SurveyForm({Key key, this.type = 'normal', this.survey}) : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    _verifyIfFieldsShouldBeFilled();
    super.initState();
  }

  void _verifyIfFieldsShouldBeFilled() {
    if (widget.type == 'edit') {
      _titleController.text = widget.survey.name;
      _urlController.text = widget.survey.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationColors.appBarColor,
        elevation: 0,
        title: Text(_determineTitleText()),
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

  String _determineTitleText() {
    if (widget.type == 'edit') {
      return 'Edite o questionário';
    } else {
      return 'Crie um questionário';
    }
  }
}
