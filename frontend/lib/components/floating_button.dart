import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  const FloatingButton({Key key, @required this.onPressed, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
      tooltip: 'Prosseguir',
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
