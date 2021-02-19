import 'package:flutter/material.dart';

// TODO: verificar dps se é mesmo necessário ter borderless button e button e gradient button
class BorderlessButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BorderlessButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
          fontSize: 16,
        ),
      ),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }
}
