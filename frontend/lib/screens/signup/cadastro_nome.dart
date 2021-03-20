import 'package:flutter/services.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_email.dart';
import 'package:genius/utils/navigator_util.dart';
import 'package:flutter/material.dart';

class CadastroNome extends StatefulWidget {
  @override
  _CadastroNomeState createState() => _CadastroNomeState();
}

class _CadastroNomeState extends State<CadastroNome> {
  final TextEditingController _nomeController = TextEditingController();
  final NavigatorUtil navigator = NavigatorUtil();
  final User p = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          verify(context);
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
                      "Qual é o seu nome?",
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
                hint: "Nome",
                controller: _nomeController,
                type: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verify(BuildContext context) {
    final String nome = _nomeController.text.trimLeft();

    if (nome.isEmpty) {
      showSnackBar("Preencha o campo nome!", context);
    } else {
      p.setUsername(nome.trimRight());
      navigator.navigate(context, CadastroEmail(p));
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
