import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String text;

  const FloatingButton({Key key, @required this.onPressed, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: ApplicationColors.floatingButtonColor,
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () {
        onPressed();
      },
      tooltip: text,
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
