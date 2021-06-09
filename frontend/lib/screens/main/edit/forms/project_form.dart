import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../components/autocomplete_input.dart';
import '../../../../utils/application_colors.dart';
import '../../../../utils/application_typography.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';
import '../../../../models/user.dart';

class ProjectForm extends StatefulWidget {
  final User user;

  const ProjectForm({Key key, @required this.user}) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _titleController = TextEditingController();
  final _institutionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _abstractController = TextEditingController();

  final _tagsKey = GlobalKey<FlutterMentionsState>();
  final _mainTeacherKey = GlobalKey<FlutterMentionsState>();
  final _secondTeacherKey = GlobalKey<FlutterMentionsState>();

  final _participantsKey = GlobalKey<FlutterMentionsState>();

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
              child: AutoCompleteInput(
                keyController: _tagsKey,
                hint: '#tag',
                label: 'Tags',
                data: [
                  {'id': '1', 'display': 'Ciência_da_computação'},
                  {'id': '2', 'display': 'Ciências_da_Natureza'}
                ],
                triggerChar: '#',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: AutoCompleteInput(
                hint: '@usuario ou Nome completo',
                keyController: _mainTeacherKey,
                label: 'Orientador',
                data: [
                  {'id': '1', 'display': 'Sidney'},
                  {'id': '2', 'display': 'Leandro'}
                ],
                triggerChar: '@',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: AutoCompleteInput(
                hint: '@usuario ou Nome completo',
                keyController: _secondTeacherKey,
                label: 'Coorientador',
                data: [
                  {'id': '1', 'display': 'Marcia'},
                  {'id': '2', 'display': 'Fábio'}
                ],
                triggerChar: '@',
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
                formatters: [
                  DateInputFormatter(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: AutoCompleteInput(
                defaultText: widget.user.username + ' ',
                hint: '@usuario',
                keyController: _participantsKey,
                label: 'Participantes',
                data: [
                  {'id': '1', 'display': 'Guilherme'},
                  {'id': '2', 'display': 'Gabriela'}
                ],
                triggerChar: '@',
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
    var tagsText = _tagsKey.currentState.controller.text;
    var participantsText = _participantsKey.currentState.controller.text;

    var tags = tagsText.trim().split(' ');
    tags = tags.toSet().toList();

    var participants = participantsText.trim().split(' ');
    participants = participants.toSet().toList();

    debugPrint(tags.toString());
    debugPrint(participants.toString());
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
