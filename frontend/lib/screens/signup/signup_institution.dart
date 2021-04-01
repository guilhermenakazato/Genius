import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_age.dart';
import '../../utils/navigator_util.dart';

class SignUpInstitution extends StatelessWidget {
  final User person;
  final NavigatorUtil navigator = NavigatorUtil();
  final TextEditingController _institutionController = TextEditingController();

  SignUpInstitution(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          verifyInput(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qual o nome da instituição\nque você dá aula/estuda?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
            BorderlessInput(
              hint: 'Nome da instituição',
              controller: _institutionController,
              type: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  void verifyInput(BuildContext context) {
    final institution = _institutionController.text.trimLeft();

    if (institution.isEmpty) {
      showSnackBar('Preencha o campo de instituição!', context);
    } else {
      person.setInstitution(institution);
      navigator.navigate(context, SignUpAge(person));
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
