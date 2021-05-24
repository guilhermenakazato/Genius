import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../models/user.dart';

import '../../../components/data_not_found.dart';
import '../../../models/project.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/token.dart';
import '../../../components/floating_button.dart';
import '../../../utils/application_typography.dart';
import '../../../utils/application_colors.dart';
import '../../../components/gradient_button.dart';
import '../../../components/input_with_animation.dart';

class EditProjects extends StatefulWidget {
  @override
  _EditProjectsState createState() => _EditProjectsState();
}

class _EditProjectsState extends State<EditProjects> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _mainTeacherController = TextEditingController();
  final TextEditingController _secondTeacherController =
      TextEditingController();

  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _abstractController = TextEditingController();
  final TextEditingController _archivesController = TextEditingController();
  Future<String> _userData;
  final _tokenObject = Token();

  @override
  void initState() {
    _userData = getData();
    super.initState();
  }

  Future<String> getData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));
          final projects = user.projects;

          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: ApplicationColors.splashColor,
            ),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingButton(
                onPressed: () {},
                icon: Icons.add,
                text: 'Adicionar',
              ),
              body: _verifyWhichWidgetShouldBeDisplayed(projects),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(List<Project> projects) {
    if (projects.isEmpty) {
      return DataNotFound(
        text: 'Você ainda não tem\nnenhum projeto',
      );
    } else {
      return SingleChildScrollView(
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
            _submitArchive(),
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
      );
    }
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

  Widget _submitArchive() {
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
