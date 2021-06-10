import 'package:flutter/material.dart';
import 'package:genius/utils/application_colors.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {},
      label: Text(text),
      backgroundColor: ApplicationColors.tileColor,
    );
  }
}
