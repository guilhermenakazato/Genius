import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_local.dart';
import 'package:genius/utils/navigator_util.dart';

// TODO: documentar
class CadastroAge extends StatefulWidget {
  final User p;

  CadastroAge(this.p);

  @override
  _CadastroAgeState createState() => _CadastroAgeState();
}

class _CadastroAgeState extends State<CadastroAge> {
  int age = 0;

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
                  Center(
                    child: Text(
                      "10",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "11",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "12",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "13",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "14",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "15",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "16",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "17",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "18",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "19",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "20",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "21",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "22",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "23",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "24",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "25",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "26",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "27",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "28",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "29",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "30",
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
