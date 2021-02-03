import 'package:flutter/material.dart';

class ModListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;

  const ModListTile(
      {Key key, @required this.text, @required this.icon, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: const Color(0xff202020),
      child: InkWell(
        onTap: () {
          function != null ? function() : debugPrint("tem nd aí moço");
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
