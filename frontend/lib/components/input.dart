import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  const Input({Key key, this.hint, this.obscure = false, this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InputState();
  }
}

class InputState extends State<Input> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _selected ? 370 : 250,
      duration: Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 4),
        child: FocusScope(
          child: Focus(
            onFocusChange: (focus){
              setState((){
                _selected = !_selected;
              });
            },
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscure,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              cursorColor: const Color(0xffab84e5),
              decoration: InputDecoration(
                hintText: widget.hint.toUpperCase(),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color.fromARGB(200, 171, 132, 229),
                  fontWeight: FontWeight.w900,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: const Color(0xffab84e5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: const Color(0xffab84e5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Gotham",
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
