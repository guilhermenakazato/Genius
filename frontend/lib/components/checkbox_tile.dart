import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class CheckboxTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final void Function(bool) onChanged;
  final bool initialValue;

  const CheckboxTile({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onChanged,
    @required this.initialValue,
  }) : super(key: key);

  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  @override
  void initState() {
    checked = widget.initialValue;
    super.initState();
  }

  bool checked;

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        activeColor: ApplicationColors.checkboxColor,
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
