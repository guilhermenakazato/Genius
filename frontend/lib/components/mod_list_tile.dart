import 'package:flutter/material.dart';

class ModListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;
  final String type;

  const ModListTile(
      {Key key,
      @required this.text,
      @required this.icon,
      this.function,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: const Color(0xff202020),
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
            style: TextStyle(
              color: _changeColorIfTypeIsWarning(context),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  Color _changeColorIfTypeIsWarning(BuildContext context) {
    if (type == 'warning') {
      return Colors.red;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}
