import 'package:flutter/material.dart';
import 'package:genius/utils/application_typography.dart';

import '../utils/application_colors.dart';

class ModListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;
  final String type;

  const ModListTile({
    Key key,
    @required this.text,
    @required this.icon,
    this.function,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: ApplicationColors.switchTileColor,
      child: InkWell(
        onTap: () {
          if (function != null) {
            function();
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
}
