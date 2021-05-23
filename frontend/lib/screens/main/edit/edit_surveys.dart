import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/survey.dart';
import '../../../models/user.dart';
import '../../../models/token.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../utils/application_colors.dart';
import '../../../components/gradient_button.dart';
import '../../../components/input_with_animation.dart';
import '../../../components/floating_button.dart';

class EditSurveys extends StatefulWidget {
  @override
  _EditSurveysState createState() => _EditSurveysState();
}

class _EditSurveysState extends State<EditSurveys> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
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
          final surveys = user.surveys;

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
              body: _verifyWhichWidgetShouldBeDisplayed(surveys),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(List<Survey> surveys) {
    if (surveys.isEmpty) {
      return Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0,-30),
              child: Column(
                children: [
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    size: 100,
                    color: ApplicationColors.notFoundColor,
                  ),
                  Text(
                    'Você ainda não tem\nnenhum questionário',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ApplicationColors.notFoundColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              onPressed: () {},
              text: 'Salvar',
              width: 270,
              height: 50,
            ),
          ),
        ],
      );
    }
  }
}
