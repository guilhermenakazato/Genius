import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class CheckboxTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final void Function(bool) onChanged;

  const CheckboxTile(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.onChanged})
      : super(key: key);

  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: ApplicationColors.tileColor,
      ),
      child: CheckboxListTile(
        title: Text(widget.text),
        value: checked,
        onChanged: (bool value) {
          setState(() {
            checked = value;
            _handleValueChange(checked);
          });
        },
        secondary: Icon(widget.icon),
      ),
    );
  }

  void _handleValueChange(bool value) {
    widget.onChanged(value);
  }
}
