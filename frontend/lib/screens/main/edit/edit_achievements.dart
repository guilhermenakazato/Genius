import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../http/exceptions/http_exception.dart';
import '../../../components/warning_dialog.dart';
import '../../../http/webclients/achievement_webclient.dart';
import '../../../components/achievement_card.dart';
import '../../../utils/navigator_util.dart';
import '../../../components/data_not_found.dart';
import '../../../models/achievement.dart';
import '../../../models/user.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/token.dart';
import '../../../utils/application_colors.dart';
import '../../../components/floating_button.dart';
import 'forms/achievement_form.dart';

// TODO: botar design da edição de conquistas
class EditConquistas extends StatefulWidget {
  @override
  _EditConquistasState createState() => _EditConquistasState();
}

class _EditConquistasState extends State<EditConquistas> {
  Future<String> _userData;
  final _tokenObject = Token();
  final navigator = NavigatorUtil();

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
          final achievements = user.achievements;

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
                    AchievementForm(
                      userId: user.id,
                    ),
                    () {
                      setState(() {
                        _userData = getData();
                      });
                    },
                  );
                },
                icon: Icons.add,
                text: 'Adicionar',
              ),
              body: _verifyWhichWidgetShouldBeDisplayed(achievements),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(List<Achievement> achievements) {
    if (achievements.isEmpty) {
      return DataNotFound(
        text: 'Você ainda não tem\nnenhuma conquista',
      );
    } else {
      return _listOfCards(achievements);
    }
  }

  Widget _listOfCards(List<Achievement> achievements) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return AchievementCard(
          achievement: achievements[index],
          onDelete: () {
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
                      _deleteAchievement(
                        achievements[index].id,
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
          onEdit: () {
            navigator.navigateAndReload(
              context,
              AchievementForm(
                type: 'edit',
                achievement: achievements[index],
              ),
              () {
                setState(
                  () {
                    _userData = getData();
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _deleteAchievement(int achievementId, BuildContext context) async {
    final _webClient = AchievementWebClient();
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.deleteAchievement(achievementId).catchError((error) {
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
