// TODO: documentar
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {},
      label: Text(text),
    );
  }
}
