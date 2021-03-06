import 'package:flutter/material.dart';

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
