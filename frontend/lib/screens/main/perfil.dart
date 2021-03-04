import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';

// documentar?
// TODO: procurar sobre como aumentar o tamanho da imagem sem perder qualidade
class Perfil extends StatelessWidget {
  final User user;

  const Perfil({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 8),
            child: Image.asset(
              "assets/sem-foto.png",
            ),
          ),
          Text(
            user.username,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}
