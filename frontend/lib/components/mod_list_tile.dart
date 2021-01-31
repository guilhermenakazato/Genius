import 'package:flutter/material.dart';

// TODO: documentar
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
          function();
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xffab84e5),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: const Color(0xffab84e5),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
