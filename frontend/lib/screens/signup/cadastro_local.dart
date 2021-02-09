import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';

// TODO: documentar
class CadastroLocal extends StatelessWidget {
  final User p;
  final TextEditingController _localController = TextEditingController();

  CadastroLocal(this.p);

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
          children: <Widget>[
            Text(
              "E, por fim, aonde você mora?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            BorderlessInput(
                hint: "Cidade",
                controller: _localController,
                type: TextInputType.streetAddress),
          ],
        ),
      ),
    );
  }

  void verify(BuildContext context) {
    final String local = _localController.text;

    if (local.isEmpty) {
      showSnackBar("Preencha o campo local!", context);
    } else {
      p.setLocal(local);
      debugPrint(p.toString());
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
