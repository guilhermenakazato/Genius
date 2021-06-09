import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/navigator_util.dart';
import '../../../models/user.dart';
import '../../../components/data_not_found.dart';
import '../../../models/project.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/token.dart';
import '../../../components/floating_button.dart';
import '../../../utils/application_colors.dart';
import 'forms/project_form.dart';

// TODO: botar design da edição de projetos
class EditProjects extends StatefulWidget {
  @override
  _EditProjectsState createState() => _EditProjectsState();
}

class _EditProjectsState extends State<EditProjects> {
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
          final projects = user.projects;

          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: ApplicationColors.splashColor,
            ),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingButton(
                onPressed: () {
                  navigator.navigate(context, ProjectForm(user: user,));
                },
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
      return Container();
    }
  }
}
