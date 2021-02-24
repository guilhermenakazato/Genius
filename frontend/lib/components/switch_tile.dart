import 'package:flutter/cupertino.dart';
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
    return MergeSemantics(
      child: Ink(
        color: const Color(0xff202020),
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            widget.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
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
}
