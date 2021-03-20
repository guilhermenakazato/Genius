import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/gradient_button.dart';
import 'package:genius/http/exceptions/http_exception.dart';
import 'package:genius/http/webclients/cadastro_webclient.dart';
import 'package:genius/models/user.dart';
import 'package:genius/utils/navigator_util.dart';
import '../login.dart';

class CadastroLocal extends StatefulWidget {
  final User p;

  CadastroLocal(this.p);

  @override
  _CadastroLocalState createState() => _CadastroLocalState();
}

class _CadastroLocalState extends State<CadastroLocal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _CadastroLocalBody(widget.p),
    );
  }
}

class _CadastroLocalBody extends StatelessWidget {
  final User p;

  _CadastroLocalBody(this.p);

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(builder: (buildContext) => _CadastroLocalContent(p)),
    );
  }
}

class _CadastroLocalContent extends StatelessWidget {
  final TextEditingController _localController = TextEditingController();
  final User p;

  _CadastroLocalContent(this.p);

  @override
  Widget build(BuildContext context) {
    return Align(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BorderlessInput(
              hint: "Cidade",
              controller: _localController,
              type: TextInputType.streetAddress,
            ),
          ),
          GradientButton(
            onPressed: () {
              verify(context);
            },
            text: "Finalizar cadastro".toUpperCase(),
          ),
        ],
      ),
    );
  }

  void verify(BuildContext context) {
    final String local = _localController.text.trimLeft();

    debugPrint(p.toString());
    if (local.isEmpty) {
      showSnackBar("Preencha o campo de local!", context);
    } else {
      p.setLocal(local.trimRight());
      debugPrint(p.toString());
      fazerCadastro(p, context);
    }
  }

  void fazerCadastro(User p, BuildContext context) async {
    final CadastroWebClient _webClient = CadastroWebClient();
    final progress = ProgressHUD.of(context);
    final NavigatorUtil navigator = NavigatorUtil();
    bool signed = false;

    progress.show();
    signed = await _webClient.cadastro(p).catchError((e) {
      showSnackBar(e.message, context);
    }, test: (e) => e is HttpException).catchError((e) {
      showSnackBar(
        "Erro: o tempo para fazer login excedeu o esperado.",
        context,
      );
    }, test: (e) => e is TimeoutException).catchError((e) {
      showSnackBar(
        "Erro desconhecido.",
        context,
      );
      debugPrint(e.toString());
    }, test: (e) => e is Exception);

    progress.dismiss();
    if (signed) {
      navigator.navigateAndReplace(context, Login());
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
