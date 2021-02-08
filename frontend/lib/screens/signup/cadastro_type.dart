import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';

class CadastroType extends StatelessWidget {
  final User p;

  CadastroType(this.p);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(p.password),
      ],
    );
  }
}
