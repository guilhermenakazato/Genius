import 'package:flutter/material.dart';

import '../utils/application_typography.dart';

class BorderlessButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;

  const BorderlessButton({
    Key key,
    @required this.onPressed,
    @required this.text, @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: ApplicationTypography.borderlessButton(color),
      ),
    );
  }
}
