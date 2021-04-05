import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;

  const FloatingButton({Key key, @required this.onPressed}) : super(key: key);

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
        Icons.arrow_forward_ios,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
