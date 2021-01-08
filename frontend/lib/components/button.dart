import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onClick;
  final double width;
  final double height;

  const Button(
      {Key key,
      @required this.text,
      @required this.onClick,
      this.width = 95,
      this.height = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: () {
          onClick();
        },
        splashColor: const Color.fromARGB(200, 171, 132, 229),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: const Color(0xffab84e5),
            width: 3,
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: const Color(0xffab84e5),
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
