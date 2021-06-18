import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/genius_toast.dart';

import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_age.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpInstitution extends StatelessWidget {
  final User person;
  final _navigator = NavigatorUtil();
  final _institutionController = TextEditingController();

  SignUpInstitution(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _verifyInput(context);
        },icon: Icons.arrow_forward_ios,
        text: 'Prosseguir',
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qual o nome da instituição\nque você estuda/trabalha?',
              textAlign: TextAlign.center,
              style: ApplicationTypography.secondarySignUpText,
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

  void _verifyInput(BuildContext context) {
    final _institution = _institutionController.text.trimLeft();

    if (_institution.isEmpty) {
      GeniusToast.showToast('Preencha o campo de instituição!');
    } else {
      person.setInstitution(_institution);
      _navigator.navigate(context, SignUpAge(person));
    }
  }
}
