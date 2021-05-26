import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:genius/components/gradient_button.dart';
import 'package:genius/components/input_with_animation.dart';

import '../../../../utils/application_colors.dart';
import '../../../../utils/application_typography.dart';

class ProjectForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _tagsController = TextEditingController();
  final _mainTeacherController = TextEditingController();
  final _secondTeacherController = TextEditingController();

  final _institutionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _participantsController = TextEditingController();
  final _abstractController = TextEditingController();
  final _archivesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationColors.appBarColor,
        elevation: 0,
        title: Text('Crie um projeto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
              child: InputWithAnimation(
                controller: _titleController,
                type: TextInputType.name,
                label: 'Título do projeto',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _tagsController,
                type: TextInputType.text,
                label: 'Tags',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _mainTeacherController,
                type: TextInputType.name,
                label: 'Orientador',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _secondTeacherController,
                type: TextInputType.name,
                label: 'Coorientador',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _institutionController,
                type: TextInputType.name,
                label: 'Instituição',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _startDateController,
                type: TextInputType.datetime,
                label: 'Data de início',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _participantsController,
                type: TextInputType.name,
                label: 'Participantes',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: InputWithAnimation(
                controller: _abstractController,
                type: TextInputType.multiline,
                label: 'Resumo',
                allowMultilines: true,
              ),
            ),
            _submitArchive(context),
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
    );
  }

  void _handleFormSubmit() {
    var title = _titleController.text;
    var tags = _tagsController.text;
    var mainTeacher = _mainTeacherController.text;
    var secondTeacher = _secondTeacherController.text;
    var institution = _institutionController.text;
    var startDate = _startDateController.text;
    var participants = _participantsController.text;
    var abstractText = _abstractController.text;
    var archives = _archivesController.text;
  }

  Widget _submitArchive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(30),
          dashPattern: [8, 4],
          color: ApplicationColors.primary,
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 46,
                  color: ApplicationColors.primary,
                ),
                Text(
                  'Adicionar\nanexo',
                  textAlign: TextAlign.center,
                  style: ApplicationTypography.submitArchiveText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}