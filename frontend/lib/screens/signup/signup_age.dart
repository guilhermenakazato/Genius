import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_local.dart';
import '../../utils/navigator_util.dart';

class SignUpAge extends StatefulWidget {
  final User person;

  SignUpAge(this.person);

  @override
  _SignUpAgeState createState() => _SignUpAgeState();
}

class _SignUpAgeState extends State<SignUpAge> {
  int _age = 0;
  final _ages = [for(var i = 10; i <= 50; i++) i];
  final navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _nextScreen(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qual a sua idade?',
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
                  _age = value;
                },
                children: <Widget>[
                  for(var number in _ages)
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

  void _nextScreen(BuildContext context) {
    widget.person.setAge((_age + 10).toString());
    navigator.navigate(context, SignUpLocal(widget.person));
  }
}
