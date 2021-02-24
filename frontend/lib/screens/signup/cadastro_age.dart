import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_local.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroAge extends StatefulWidget {
  final User p;

  CadastroAge(this.p);

  @override
  _CadastroAgeState createState() => _CadastroAgeState();
}

class _CadastroAgeState extends State<CadastroAge> {
  int age = 0;
  var ages = [for(var i = 10; i <= 50; i++) i];
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          nextScreen(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Qual a sua idade?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            Container(
              height: 100,
              width: 150,
              child: CupertinoPicker(
                itemExtent: 50,
                backgroundColor: Colors.transparent,
                onSelectedItemChanged: (int value) {
                  age = value;
                },
                children: <Widget>[
                  for(var number in ages)
                  Center(
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen(BuildContext context) {
    widget.p.setAge((age + 10).toString());
    navigator.navigate(context, CadastroLocal(widget.p));
  }
}
