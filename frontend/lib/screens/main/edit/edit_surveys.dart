import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../http/exceptions/http_exception.dart';
import '../../../http/webclients/survey_webclient.dart';
import '../../../components/warning_dialog.dart';
import '../../../components/borderless_button.dart';
import '../../../utils/navigator_util.dart';
import '../../../components/data_not_found.dart';
import '../../../models/survey.dart';
import '../../../models/user.dart';
import '../../../models/token.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../utils/application_colors.dart';
import '../../../components/floating_button.dart';
import 'forms/survey_form.dart';

// TODO: arrumar texto do questionário e do card no meio do card
class EditSurveys extends StatefulWidget {
  @override
  _EditSurveysState createState() => _EditSurveysState();
}

class _EditSurveysState extends State<EditSurveys> {
  Future<User> _userData;
  final _tokenObject = Token();
  final navigator = NavigatorUtil();
  List<bool> isOpen;

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

    isOpen = List<bool>.filled(_user.surveys.length, false);

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
              body:
                  _verifyWhichWidgetShouldBeDisplayed(surveys, isOpen, user.id),
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
    List<bool> isOpen,
    int userId,
  ) {
    if (surveys.isEmpty) {
      return DataNotFound(
        text: 'Você ainda não tem\nnenhum questionário',
      );
    } else {
      return _listOfSurveys(surveys, isOpen, userId);
    }
  }

  Widget _listOfSurveys(List<Survey> surveys, List<bool> isOpen, int userId) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8.0, left: 8),
          child: ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isOpen[index] = !isExpanded;
              });
            },
            children: surveys.asMap().entries.map<ExpansionPanel>((entry) {
              return ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: ApplicationColors.secondCardColor,
                isExpanded: isOpen[entry.key],
                body: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          bottom: 4,
                          top: 4,
                        ),
                        child: Text(
                          'Link do seu questionário: ${entry.value.link}',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: BorderlessButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (
                                    BuildContext context,
                                  ) =>
                                      WarningDialog(
                                    content:
                                        'Caso exclua, não há como recuperá-lo!',
                                    title: 'Excluir questionário?',
                                    acceptFunction: () {
                                      _deleteSurvey(entry.value.id, context);
                                    },
                                    cancelFunction: () {
                                      navigator.goBack(context);
                                    },
                                    acceptText: 'Excluir',
                                  ),
                                ).whenComplete(() => setState(() {}));
                              },
                              text: 'Excluir',
                              color: ApplicationColors.atentionColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: BorderlessButton(
                              onPressed: () {
                                navigator.navigateAndReload(
                                  context,
                                  SurveyForm(
                                    type: 'edit',
                                    survey: entry.value,
                                  ),
                                  () {
                                    setState(() {
                                      _userData = getData();
                                    });
                                  },
                                );
                              },
                              text: 'Editar',
                              color: ApplicationColors.editButtonColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(entry.value.name),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


  // TODO :arrumar isso e implementar exclusão
  void _deleteSurvey(int surveyId, BuildContext context) async {
    final _webClient = SurveyWebClient();
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.deleteSurvey(surveyId).catchError((error) {
      progress.dismiss();
      _showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      _showToast('Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      _showToast('Erro desconhecido.');
    });

    progress.dismiss();
    _showToast('Questionário deletado com sucesso.');
    navigator.goBack(context);
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ApplicationColors.toastColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
