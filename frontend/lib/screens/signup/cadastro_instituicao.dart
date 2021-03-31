// TODO: documentar
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_age.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroInstituicao extends StatelessWidget {
  final User p;
  final NavigatorUtil navigator = NavigatorUtil();
  final TextEditingController _instituicaoController = TextEditingController();

  CadastroInstituicao(this.p);

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
              controller: _instituicaoController,
              type: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  void verify(BuildContext context) {
    final instituicao = _instituicaoController.text.trimLeft();

    if (instituicao.isEmpty) {
      showSnackBar('Preencha o campo de instituição!', context);
    } else {
      p.setInstituicao(instituicao);
      navigator.navigate(context, CadastroAge(p));
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
