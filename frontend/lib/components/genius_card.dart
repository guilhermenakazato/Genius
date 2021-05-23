import 'package:flutter/material.dart';

class GeniusCard extends StatelessWidget {
  final Function onTap;
  final List<Widget> children;
  final Color cardColor;

  const GeniusCard({Key key, @required this.onTap, @required this.cardColor, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: cardColor,
          ),
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              child: Stack(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
