import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Widget widget;
  const Button({Key key, this.text, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 45,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return widget;
          }));
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
