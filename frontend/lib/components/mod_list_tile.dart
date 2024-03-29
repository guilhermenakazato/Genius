import 'package:flutter/material.dart';

import '../utils/application_typography.dart';
import '../utils/application_colors.dart';

class ModListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onClick;
  final String type;
  final String position;

  const ModListTile({
    Key key,
    @required this.text,
    @required this.icon,
    this.onClick,
    this.type = 'center',
    this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: _determineBorderRadius(),
        color: ApplicationColors.tileColor,
      ),
      child: InkWell(
        borderRadius: _determineBorderRadius(),
        onTap: () {
          if (onClick != null) {
            onClick();
          }
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: _changeColorIfTypeIsWarning(context),
          ),
          title: Text(
            text,
            style: ApplicationTypography.listTileText(
              _changeColorIfTypeIsWarning(context),
            ),
          ),
        ),
      ),
    );
  }

  Color _changeColorIfTypeIsWarning(BuildContext context) {
    if (type == 'warning') {
      return ApplicationColors.atentionColor;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  BorderRadius _determineBorderRadius() {
    if (position == 'top') {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      );
    } else if (position == 'bottom') {
      return BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else {
      return null;
    }
  }
}
