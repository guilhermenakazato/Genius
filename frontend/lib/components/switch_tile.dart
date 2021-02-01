import 'package:flutter/material.dart';

class SwitchTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function function;

  const SwitchTile(
      {Key key, @required this.icon, @required this.text, this.function})
      : super(key: key);

  @override
  _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: const Color(0xff202020),
      child: InkWell(
        onTap: () {
          widget.function();
        },
        child: SwitchListTile(
          value: _isSwitched,
          title: Text(
            widget.text,
            style: TextStyle(
              color: const Color(0xffab84e5),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          secondary: Icon(
            widget.icon,
            color: const Color(0xffab84e5),
          ),
          onChanged: (bool value) {
            setState(() {
              _isSwitched = value;
            });
          },
          activeColor: const Color(0xffab84e5),
        ),
      ),
    );
  }
}
