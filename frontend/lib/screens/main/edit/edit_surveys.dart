import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/genius_toast.dart';
import '../../../components/survey_expandable_card.dart';
import '../../../components/warning_dialog.dart';
import '../../../http/exceptions/http_exception.dart';
import '../../../http/webclients/survey_webclient.dart';
import '../../../utils/navigator_util.dart';
import '../../../components/data_not_found.dart';
import '../../../models/survey.dart';
import '../../../models/user.dart';
import '../../../models/token.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../utils/application_colors.dart';
import '../../../components/floating_button.dart';
import 'forms/survey_form.dart';

class EditSurveys extends StatefulWidget {
  @override
  _EditSurveysState createState() => _EditSurveysState();
}

class _EditSurveysState extends State<EditSurveys> {
  Future<User> _userData;
  final _tokenObject = Token();
  final navigator = NavigatorUtil();

  @override
  void initState() {
    _userData = getData();
    super.initState();
  }

  Future<User> getData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();

    dynamic _user = await _webClient.getUserData(_token);
    _user = User.fromJson(jsonDecode(_user));

    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userData,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          final surveys = user.surveys;

          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: ApplicationColors.splashColor,
            ),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingButton(
                onPressed: () {
                  navigator.navigateAndReload(
                    context,
                    SurveyForm(userId: user.id),
                    () {
                      setState(
                        () {
                          _userData = getData();
                        },
                      );
                    },
                  );
                },
                icon: Icons.add,
                text: 'Adicionar',
              ),
              body: _verifyWhichWidgetShouldBeDisplayed(surveys, user.id),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(
    List<Survey> surveys,
    int userId,
  ) {
    if (surveys.isEmpty) {
      return DataNotFound(
        text: 'Você ainda não tem\nnenhum questionário',
      );
    } else {
      return _listOfSurveys(surveys, userId);
    }
  }

  Widget _listOfSurveys(List<Survey> surveys, int userId) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8.0, left: 8),
          child: SurveyExpandableCard(
            surveys: surveys,
            type: 'edit',
            onEdit: (survey) {
              navigator.navigateAndReload(
                context,
                SurveyForm(
                  type: 'edit',
                  survey: survey,
                ),
                () {
                  setState(() {
                    _userData = getData();
                  });
                },
              );
            },
            onDelete: (survey) {
              showDialog(
                context: context,
                builder: (
                  BuildContext context,
                ) =>
                    ProgressHUD(
                  borderColor: Theme.of(context).primaryColor,
                  indicatorWidget: SpinKitPouringHourglass(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Builder(
                    builder: (context) => WarningDialog(
                      content: 'Caso exclua, não há como recuperá-lo!',
                      title: 'Excluir questionário?',
                      acceptFunction: () {
                        _deleteSurvey(
                          survey.id,
                          context,
                        );
                      },
                      cancelFunction: () {
                        navigator.goBack(
                          context,
                        );
                      },
                      acceptText: 'Excluir',
                    ),
                  ),
                ),
              ).then(
                (value) => setState(() {
                  _userData = getData();
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  void _deleteSurvey(int surveyId, BuildContext context) async {
    final _webClient = SurveyWebClient();
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();

    progress.show();

    await _webClient.deleteSurvey(surveyId, token).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro desconhecido.');
    });

    progress.dismiss();
    GeniusToast.showToast('Questionário deletado com sucesso.');
    navigator.goBack(context);
  }
}
