import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/application_typography.dart';
import '../utils/application_colors.dart';

class SwitchTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function function;
  final String position;

  const SwitchTile(
      {Key key,
      @required this.icon,
      @required this.text,
      this.function,
      this.position})
      : super(key: key);

  @override
  _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: _determineBorderRadius(),
          color: ApplicationColors.tileColor,
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: _determineBorderRadius(),
          ),
          leading: Icon(
            widget.icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(widget.text, style: ApplicationTypography.switchTile),
          trailing: CupertinoSwitch(
            value: _isSwitched,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool value) {
              setState(() {
                _isSwitched = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _isSwitched = !_isSwitched;
            });
          },
        ),
      ),
    );
  }

  BorderRadius _determineBorderRadius() {
    if (widget.position == 'top') {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      );
    } else if (widget.position == 'bottom') {
      return BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else {
      return null;
    }
  }
}
