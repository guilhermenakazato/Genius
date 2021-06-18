import 'dart:async';
import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../utils/genius_toast.dart';
import '../../../../http/webclients/user_webclient.dart';
import '../../../../http/exceptions/http_exception.dart';
import '../../../../http/webclients/project_webclient.dart';
import '../../../../utils/navigator_util.dart';
import '../../../../models/tag.dart';
import '../../../../components/autocomplete_input.dart';
import '../../../../utils/application_colors.dart';
import '../../../../utils/application_typography.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';
import '../../../../models/user.dart';
import '../../../../models/project.dart';
import '../../../../http/webclients/tags_webclient.dart';
import '../../../../utils/convert.dart';

class ProjectForm extends StatefulWidget {
  final User user;
  final String type;
  final Project project;

  const ProjectForm({
    Key key,
    @required this.user,
    this.type,
    this.project,
  }) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  String _tagsInitState = '';
  String _usernamesInitState = '';

  final _titleController = TextEditingController();
  final _institutionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _abstractController = TextEditingController();

  final _tagsKey = GlobalKey<FlutterMentionsState>();
  final _mainTeacherKey = GlobalKey<FlutterMentionsState>();
  final _secondTeacherKey = GlobalKey<FlutterMentionsState>();
  final _participantsKey = GlobalKey<FlutterMentionsState>();

  final navigator = NavigatorUtil();

  @override
  void initState() {
    _verifyIfShouldFillFormOrNot();
    super.initState();
  }

  Future<List<dynamic>> _getProjectFormData() {
    var responses = Future.wait([_getUsersData(), _getTagsData()]);

    return responses;
  }

  Future<List<User>> _getUsersData() async {
    final webClient = UserWebClient();
    final users = await webClient.getAllUsers();
    final usersList = Convert.convertToListOfUsers(jsonDecode(users));

    return usersList;
  }

  Future<List<Tag>> _getTagsData() async {
    final webClient = TagsWebClient();
    final tags = await webClient.getAllTags();
    final tagsList = Convert.convertToListOfTags(jsonDecode(tags));

    return tagsList;
  }

  void _verifyIfShouldFillFormOrNot() {
    if (widget.type == 'edit') {
      _tagsInitState = _transformListOfTagsIntoStringOfTags(
        widget.project.tags,
      );

      _usernamesInitState = _transformListOfUsersIntoStringOfUsernames(
        widget.project.participants,
      );

      _titleController.text = widget.project.name;
      _institutionController.text = widget.project.institution;
      _startDateController.text = widget.project.startDate;
      _abstractController.text = widget.project.abstractText;
    }
  }

  String _transformListOfUsersIntoStringOfUsernames(List<User> users) {
    var _stringOfUsers = '';

    users.forEach((user) {
      _stringOfUsers += user.username;
      _stringOfUsers += ' ';
    });

    return _stringOfUsers;
  }

  String _transformListOfTagsIntoStringOfTags(List<Tag> tags) {
    var _stringOfTags = '';

    tags.forEach((tag) {
      _stringOfTags += tag.name;
      _stringOfTags += ' ';
    });

    return _stringOfTags;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(
        builder: (loaderContext) => FutureBuilder(
          future: _getProjectFormData(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var usersList = [];
              usersList = _defineUserAutocomplete(snapshot.data[0]);

              var tagsList = [];
              tagsList = _defineTagAutocomplete(snapshot.data[1]);

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: ApplicationColors.appBarColor,
                  elevation: 0,
                  title: Text(_defineAppBarText()),
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
                          defaultText: _defineDefaultTagsText(),
                          keyController: _tagsKey,
                          hint: '#tag',
                          label: 'Tags',
                          data: tagsList,
                          type: 'tag',
                          triggerChar: '#',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                        child: AutoCompleteInput(
                          defaultText: _defineDefaultMainTeacherText(),
                          hint: '@usuario ou Nome completo',
                          keyController: _mainTeacherKey,
                          label: 'Orientador',
                          data: usersList,
                          triggerChar: '@',
                          position: SuggestionPosition.Bottom,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                        child: AutoCompleteInput(
                          defaultText: _defineDefaultSecondTeacherText(),
                          hint: '@usuario ou Nome completo',
                          keyController: _secondTeacherKey,
                          label: 'Coorientador',
                          data: usersList,
                          triggerChar: '@',
                          position: SuggestionPosition.Top,
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
                          defaultText: _defineDefaultParticipantsText(),
                          hint: '@usuario',
                          keyController: _participantsKey,
                          label: 'Participantes',
                          data: usersList,
                          triggerChar: '@',
                          position: SuggestionPosition.Top,
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
                            _handleFormSubmit(loaderContext);
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
            } else {
              return SpinKitFadingCube(color: ApplicationColors.primary);
            }
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _defineTagAutocomplete(List<Tag> tags) {
    var listOfTagsWithMap = <Map<String, dynamic>>[];

    tags.forEach((tag) {
      var map = <String, dynamic>{};

      map['display'] = tag.name.replaceAll('#', '');
      map['id'] = tag.id.toString();

      listOfTagsWithMap.add(map);
    });

    return listOfTagsWithMap;
  }

  List<Map<String, dynamic>> _defineUserAutocomplete(List<User> users) {
    var listOfUsersWithMap = <Map<String, dynamic>>[];

    users.forEach((user) {
      var map = <String, dynamic>{};

      map['display'] = user.username.replaceAll('@', '');
      map['id'] = user.id.toString();
      map['name'] = user.name;

      listOfUsersWithMap.add(map);
    });

    return listOfUsersWithMap;
  }

  void _handleFormSubmit(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress.show();

    var name = _titleController.text.trim();
    var institution = _institutionController.text.trim();
    var startDate = _startDateController.text.trim();
    var mainTeacher = _mainTeacherKey.currentState.controller.text.trim();
    var secondTeacher = _secondTeacherKey.currentState.controller.text.trim();
    var abstractText = _abstractController.text.trim();

    var tagsText = _tagsKey.currentState.controller.text;
    var participantsText = _participantsKey.currentState.controller.text;

    var tags = tagsText.trim().split(' ');
    tags = tags.toSet().toList();

    var participants = participantsText.trim().split(' ');
    participants = participants.toSet().toList();

    var projectTitleExists =
        await _projectTitleAlreadyExists(name, widget.project);

    final tagsVerificationPassed = _tagsStructureIsCorrect(
      tags,
      context,
    );
    final participantsVerificationPassed = _participantsStructureIsCorrect(
      participants,
      context,
    );
    final dateVerificationPassed = _dateIsValid(
      startDate,
      context,
    );

    if (projectTitleExists) {
      progress.dismiss();
      GeniusToast.showToast(
        'Ops! Parece que alguém já está usando o título de projeto que você tentou colocar.',
      );
    } else if (tagsVerificationPassed &&
        participantsVerificationPassed &&
        dateVerificationPassed) {
      var mainTeacherText;
      var secondTeacherText;
      var mainTeacherNameText;
      var secondTeacherNameText;

      if (mainTeacher.contains('@')) {
        mainTeacherText = mainTeacher;
        mainTeacherNameText = null;
      } else {
        mainTeacherText = null;
        mainTeacherNameText = mainTeacher;
      }

      if (secondTeacher.contains('@') && secondTeacher != null) {
        secondTeacherText = secondTeacher;
        secondTeacherNameText = null;
      } else if (secondTeacher != null && secondTeacher != '') {
        secondTeacherText = null;
        secondTeacherNameText = secondTeacher;
      } else {
        secondTeacherText = null;
        secondTeacherNameText = null;
      }

      var project = Project(
        name: name,
        institution: institution,
        startDate: startDate,
        participants: participants,
        tags: tags,
        abstractText: abstractText,
        mainTeacher: mainTeacherText,
        mainTeacherName: mainTeacherNameText,
        secondTeacher: secondTeacherText,
        secondTeacherName: secondTeacherNameText,
      );

      if (widget.type == 'edit') {
        _updateProject(project, widget.project.id, context);
      } else {
        _createProject(project, context);
      }
    }
  }

  bool _dateIsValid(String date, BuildContext context) {
    final progress = ProgressHUD.of(context);

    var dateArray = date.split('/');
    var day = dateArray[0];
    var month = dateArray[1];
    var year = dateArray[2];

    var formattedDate = year + '-' + month + '-' + day;
    var newDate = DateTime.tryParse(formattedDate);

    if (newDate == null) {
      GeniusToast.showToast('Formato de data inválido.');
      progress.dismiss();
      return false;
    } else {
      var greaterThanNow = DateTime.now().isBefore(newDate);

      if (greaterThanNow) {
        GeniusToast.showToast('Ops! Parece que um viajante do tempo passou por aqui');
        progress.dismiss();
        return false;
      } else {
        return true;
      }
    }
  }

  Future<bool> _projectTitleAlreadyExists(
    String title,
    Project oldProjectData,
  ) async {
    var projectTitleAlreadyExists = false;
    var _webClientToVerifyData = ProjectWebClient();

    if (widget.type == 'edit') {
      if (oldProjectData.name != title) {
        projectTitleAlreadyExists =
            await _webClientToVerifyData.verifyIfProjectTitleAlreadyExists(
          title,
        );
      }
    } else {
      projectTitleAlreadyExists =
          await _webClientToVerifyData.verifyIfProjectTitleAlreadyExists(
        title,
      );
    }

    return projectTitleAlreadyExists;
  }

  bool _participantsStructureIsCorrect(
      List<String> participants, BuildContext context) {
    var verification = true;
    final progress = ProgressHUD.of(context);

    if (participants.length == 1 &&
        (participants[0] == ' ' || participants[0] == '')) {
      participants.clear();
    }

    if (participants.isEmpty) {
      GeniusToast.showToast('Seu projeto tem que ter pelo menos um participante!');
      verification = false;
    } else {
      participants.forEach((participant) {
        if (!participant.startsWith('@')) {
          GeniusToast.showToast('O participante $participant está sem @!');
          verification = false;
        }
      });
    }

    if (!verification) {
      progress.dismiss();
    }

    return verification;
  }

  bool _tagsStructureIsCorrect(List<String> tags, BuildContext context) {
    var verification = true;
    final progress = ProgressHUD.of(context);

    if (tags.length == 1 && (tags[0] == ' ' || tags[0] == '')) {
      tags.clear();
    }

    if (tags.isNotEmpty) {
      tags.forEach((tag) {
        if (!tag.startsWith('#')) {
          GeniusToast.showToast('A tag $tag está sem #!');
          verification = false;
        }
      });
    }

    if (!verification) {
      progress.dismiss();
    }

    return verification;
  }

  void _createProject(Project project, BuildContext context) async {
    final _webClient = ProjectWebClient();
    final progress = ProgressHUD.of(context);

    var creationTestsPassed = await _webClient
            .createProject(project, widget.user.id)
            .catchError((error) {
          progress.dismiss();
          GeniusToast.showToast(error.message);
        }, test: (error) => error is HttpException).catchError((error) {
          progress.dismiss();
          GeniusToast.showToast('Erro: o tempo para fazer login excedeu o esperado.');
        }, test: (error) => error is TimeoutException).catchError((error) {
          progress.dismiss();
          GeniusToast.showToast('Erro desconhecido.');
        }) ??
        false;

    if (creationTestsPassed) {
      progress.dismiss();
      GeniusToast.showToast('Projeto criado com sucesso.');
      navigator.goBack(context);
    }
  }

  void _updateProject(
    Project project,
    int oldProjectId,
    BuildContext context,
  ) async {
    final _webClient = ProjectWebClient();
    final progress = ProgressHUD.of(context);

    var updateTestsPassed = await _webClient
            .updateProject(project, oldProjectId)
            .catchError((error) {
          progress.dismiss();
          GeniusToast.showToast(error.message);
        }, test: (error) => error is HttpException).catchError((error) {
          progress.dismiss();
          GeniusToast.showToast('Erro: o tempo para fazer login excedeu o esperado.');
        }, test: (error) => error is TimeoutException).catchError((error) {
          progress.dismiss();
          GeniusToast.showToast('Erro desconhecido.');
        }) ??
        false;

    if (updateTestsPassed) {
      progress.dismiss();
      GeniusToast.showToast('Projeto atualizado com sucesso.');
      navigator.goBack(context);
    }
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

  String _defineAppBarText() {
    if (widget.type == 'edit') {
      return 'Edite o projeto';
    } else {
      return 'Crie um projeto';
    }
  }

  String _defineDefaultParticipantsText() {
    if (widget.type == 'edit') {
      return _usernamesInitState;
    } else {
      return widget.user.username + ' ';
    }
  }

  String _defineDefaultTagsText() {
    if (widget.type == 'edit') {
      return _tagsInitState;
    } else {
      return null;
    }
  }

  String _defineDefaultMainTeacherText() {
    if (widget.type == 'edit') {
      if (widget.project.mainTeacher != null) {
        return widget.project.mainTeacher;
      } else if (widget.project.mainTeacherName != null) {
        return widget.project.mainTeacherName;
      } else {
        return '';
      }
    } else {
      return null;
    }
  }

  String _defineDefaultSecondTeacherText() {
    if (widget.type == 'edit') {
      if (widget.project.secondTeacher != null) {
        return widget.project.secondTeacher;
      } else if (widget.project.secondTeacherName != null) {
        return widget.project.secondTeacherName;
      } else {
        return '';
      }
    } else {
      return null;
    }
  }
}
