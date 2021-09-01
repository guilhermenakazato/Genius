import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/genius_toast.dart';
import '../../../http/exceptions/http_exception.dart';
import '../../../components/warning_dialog.dart';
import '../../../http/webclients/achievement_webclient.dart';
import '../../../components/achievement_card.dart';
import '../../../utils/navigator_util.dart';
import '../../../components/data_not_found.dart';
import '../../../models/achievement.dart';
import '../../../models/user.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/jwt_token.dart';
import '../../../utils/application_colors.dart';
import '../../../components/floating_button.dart';
import 'forms/achievement_form.dart';

class EditConquistas extends StatefulWidget {
  @override
  _EditAchievementsState createState() => _EditAchievementsState();
}

class _EditAchievementsState extends State<EditConquistas> {
  Future<String> _userData;
  final _tokenObject = JwtToken();
  final _navigator = NavigatorUtil();

  @override
  void initState() {
    _userData = getData();
    super.initState();
  }

  Future<String> getData() async {
    final userWebClient = UserWebClient();
    final jwtToken = await _tokenObject.getToken();
    final user = await userWebClient.getUserData(jwtToken);
    return user;
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
                  _navigator.navigateAndReload(
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
          type: 'edit',
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
                      _navigator.goBack(
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
            _navigator.navigateAndReload(
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
    final achievementWebClient = AchievementWebClient();
    final progress = ProgressHUD.of(context);
    final jwtToken = await _tokenObject.getToken();

    progress.show();

    await achievementWebClient.deleteAchievement(achievementId, jwtToken).catchError((error) {
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
    _navigator.goBack(context);
  }
}
