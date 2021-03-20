import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';
import 'package:tcard/tcard.dart';

// TODO: documentar
class Perfil extends StatefulWidget {
  final User user;

  Perfil({Key key, this.user}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TCardController _controller = TCardController();

  int _index = 0;

  var projetos = [for (int i = 0; i < 10; i++) i];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 8),
            child: Image.asset(
              "assets/sem-foto.png",
            ),
          ),
          Text(
            widget.user.username,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "3\nPARTNERS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "2\nPROJETOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chat,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TCard(
            size: Size(350, 400),
            controller: _controller,
            onForward: (index, info) {
              _index = index;
              debugPrint(info.direction.toString());
              setState(() {});
            },
            onBack: (index) {
              _index = index;
              setState(() {});
            },
            cards: [
              for (var projeto in projetos)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Theme.of(context).cardColor,
                    ),
                    child: InkWell(
                      onTap: () {
                        // card tá em cima
                        if (_index + 1 == projeto) {}
                      },
                      borderRadius: BorderRadius.circular(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          projeto == 0
                              ? Column(
                                children: [
                                  Image.asset("assets/pasta.png"),
                                  Text(
                                      "Passe para o lado para\nvisualizar os projetos",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                ],
                              )
                              : Text(
                                  "Projeto $projeto",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Sobre você",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Você é um " + widget.user.type,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Seu email é " + widget.user.email,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Você tem " + widget.user.age + " anos",
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Você mora em " + widget.user.local,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Você estuda em " + widget.user.instituicao,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Você tem o " + widget.user.formacao,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
