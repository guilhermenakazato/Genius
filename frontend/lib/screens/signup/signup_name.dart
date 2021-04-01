import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_email.dart';
import '../../utils/navigator_util.dart';

class SignUpName extends StatefulWidget {
  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final TextEditingController _nomeController = TextEditingController();
  final NavigatorUtil navigator = NavigatorUtil();
  final User person = User();

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Qual é o seu nome?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              BorderlessInput(
                hint: 'Nome + sobrenome',
                controller: _nomeController,
                type: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyInput(BuildContext context) {
    final name = _nomeController.text.trimLeft();

    if (name.isEmpty) {
      showSnackBar('Preencha o campo nome!', context);
    } else {
      person.setUsername(name.trimRight());
      navigator.navigate(context, SignUpEmail(person));
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
