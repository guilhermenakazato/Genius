import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int value;
  final Function(int) onChange;

  const BottomNavBar({Key key, this.value, this.onChange}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 48,
      index: widget.value,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      backgroundColor: Colors.transparent,
      items: <Widget>[
        Icon(Icons.emoji_objects, size: 24, color: Colors.white),
        Icon(Icons.person, size: 24, color: Colors.white),
        Icon(Icons.psychology, size: 24, color: Colors.white),
        Icon(Icons.search, size: 24, color: Colors.white),
        Icon(Icons.app_settings_alt, size: 24, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _handleValueChange(index);
        });
      },
    );
  }

  void _handleValueChange(int value) {
    widget.onChange(value);
  }
}
