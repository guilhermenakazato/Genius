import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/jwt_token.dart';
import '../../../../utils/genius_toast.dart';
import '../../../../utils/navigator_util.dart';
import '../../../../http/exceptions/http_exception.dart';
import '../../../../http/webclients/survey_webclient.dart';
import '../../../../models/survey.dart';
import '../../../../utils/application_colors.dart';
import '../../../../components/gradient_button.dart';
import '../../../../components/input_with_animation.dart';

class SurveyForm extends StatefulWidget {
  final String formType;
  final Survey survey;
  final int userId;

  SurveyForm({Key key, this.formType = 'normal', this.survey, this.userId})
      : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _navigator = NavigatorUtil();
  final _tokenObject = JwtToken();

  @override
  void initState() {
    _verifyIfFieldsShouldBeFilled();
    super.initState();
  }

  void _verifyIfFieldsShouldBeFilled() {
    if (widget.formType == 'edit') {
      _titleController.text = widget.survey.name;
      _urlController.text = widget.survey.link;
    }
  }

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
                      _handleFormSubmit(widget.survey, context);
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

  void _handleFormSubmit(Survey oldData, BuildContext context) {
    var title = _titleController.text;
    var url = _urlController.text;

    var survey = Survey(
      url,
      title,
    );

    if (widget.formType == 'edit') {
      _updateSurvey(survey, oldData.id, context);
    } else {
      _createSurvey(survey, context);
    }
  }

  void _createSurvey(Survey survey, BuildContext context) async {
    final surveyWebClient = SurveyWebClient();
    final progress = ProgressHUD.of(context);
    final jwtToken = await _tokenObject.getToken();

    progress.show();

    await surveyWebClient.createSurvey(survey, widget.userId, jwtToken).catchError(
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
    GeniusToast.showToast('Questionário criado com sucesso.');
    _navigator.goBack(context);
  }

  void _updateSurvey(
    Survey survey,
    int oldSurveyId,
    BuildContext context,
  ) async {
    final surveyWebClient = SurveyWebClient();
    final progress = ProgressHUD.of(context);
    final jwtToken = await _tokenObject.getToken();

    progress.show();

    await surveyWebClient.updateSurvey(survey, oldSurveyId, jwtToken).catchError(
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
    GeniusToast.showToast('Questionário atualizado com sucesso.');
    _navigator.goBack(context);
  }

  String _determineTitleText() {
    if (widget.formType == 'edit') {
      return 'Edite o questionário';
    } else {
      return 'Crie um questionário';
    }
  }
}
