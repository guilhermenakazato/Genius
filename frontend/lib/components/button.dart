import 'package:flutter/material.dart';

import '../utils/application_typography.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onClick;
  final double width;
  final double height;

  const Button(
      {Key key,
      @required this.text,
      @required this.onClick,
      this.width = 95,
      this.height = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: () {
          onClick();
        },
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        ),
        child: Text(
          text,
          style: ApplicationTypography.button,
        ),
      ),
    );
  }
}
