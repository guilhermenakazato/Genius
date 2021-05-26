import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String content;
  final String acceptText;

  final Function cancelFunction;
  final Function acceptFunction;

  const WarningDialog({
    Key key,
    @required this.title,
    @required this.content,
    @required this.cancelFunction,
    @required this.acceptFunction,
    @required this.acceptText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: cancelFunction,
          child: Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: acceptFunction,
          child: Text(acceptText),
        ),
      ],
    );
  }
}
