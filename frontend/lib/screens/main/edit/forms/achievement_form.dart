import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/token.dart';
import '../../../../utils/genius_toast.dart';
import '../../../../http/exceptions/http_exception.dart';
import '../../../../http/webclients/achievement_webclient.dart';
import '../../../../models/achievement.dart';
import '../../../../utils/navigator_util.dart';
import '../../../../utils/application_colors.dart';
import '../../../../components/checkbox_tile.dart';
import '../../../../components/dropdown_button.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';

class AchievementForm extends StatefulWidget {
  final String type;
  final int userId;
  final Achievement achievement;

  const AchievementForm({
    Key key,
    this.type,
    this.userId,
    this.achievement,
  }) : super(key: key);

  @override
  _AchievementFormState createState() => _AchievementFormState();
}

class _AchievementFormState extends State<AchievementForm> {
  String _typeController = 'Medalha';
  final _institutionController = TextEditingController();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _customizedTypeController = TextEditingController();
  bool showPositionField = false;
  final navigator = NavigatorUtil();
  final _tokenObject = Token();

  @override
  void initState() {
    _verifyIfShouldFillFormOrNot();
    super.initState();
  }

  void _verifyIfShouldFillFormOrNot() {
    if (widget.type == 'edit') {
      _institutionController.text = widget.achievement.institution;
      _nameController.text = widget.achievement.name;
      _typeController = widget.achievement.type;

      switch (widget.achievement.type) {
        case 'Medalha':
          if (widget.achievement.position != null) {
            if (widget.achievement.position.isNotEmpty) {
              showPositionField = true;
              _positionController.text = widget.achievement.position;
            }
          }
          break;
        case 'Outro':
          _customizedTypeController.text = widget.achievement.customizedType;

          if (widget.achievement.position != null) {
            if (widget.achievement.position.isNotEmpty) {
              showPositionField = true;
              _positionController.text = widget.achievement.position;
            }
          }
          break;
      }
    }
  }

  final _typeOptions = <String>[
    'Medalha',
    'Certificado',
    'Honra ao mérito',
    'Outro'
  ];

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: ApplicationColors.appBarColor,
            elevation: 0,
            title: Text(_determineTitleText()),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
                  child: DropDownButton(
                    hint: _typeController,
                    items: _typeOptions,
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
                    onPressed: () {
                      _handleFormSubmit(widget.achievement, context);
                    },
                    text: 'Salvar',
                    width: 270,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shouldShowPositionQuestionField() {
    if (_typeController == 'Medalha' || _typeController == 'Outro') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 5.0, 16, 5),
        child: CheckboxTile(
          initialValue: showPositionField,
          onChanged: (value) {
            setState(() {
              showPositionField = value;
            });
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

  void _handleFormSubmit(Achievement oldData, BuildContext context) {
    var institution = _institutionController.text;
    var name = _nameController.text;
    var position = _positionController.text;
    var type = _typeController;
    var customizedType = _customizedTypeController.text;

    if (type == 'Certificado' || type == 'Honra ao mérito') {
      position = null;
      customizedType = null;
    } else if (type == 'Medalha') {
      customizedType = null;

      if (!showPositionField) {
        position = null;
      }
    } else if (type == 'Outro') {
      if (!showPositionField) {
        position = null;
      }
    }

    var achievement = Achievement(
      institution: institution,
      name: name,
      position: position,
      type: type,
      customizedType: customizedType,
    );

    if (widget.type == 'edit') {
      _updateAchievement(achievement, oldData.id, context);
    } else {
      _createAchievement(achievement, context);
    }
  }

  void _createAchievement(Achievement achievement, BuildContext context) async {
    final achievementWebClient = AchievementWebClient();
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();
    progress.show();

    await achievementWebClient
        .createAchievement(achievement, widget.userId, token)
        .catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(
          'Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro desconhecido.');
    });

    progress.dismiss();
    GeniusToast.showToast('Conquista criada com sucesso.');
    navigator.goBack(context);
  }

  void _updateAchievement(
    Achievement achievement,
    int oldSurveyId,
    BuildContext context,
  ) async {
    final achievementWebClient = AchievementWebClient();
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();

    progress.show();

    await achievementWebClient.updateAchievement(achievement, oldSurveyId, token).catchError(
        (error) {
      progress.dismiss();
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(
          'Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro desconhecido.');
    });

    progress.dismiss();
    GeniusToast.showToast('Conquista atualizada com sucesso.');
    navigator.goBack(context);
  }

  String _determineTitleText() {
    if (widget.type == 'edit') {
      return 'Edite o questionário';
    } else {
      return 'Crie um questionário';
    }
  }
}
