import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/application_typography.dart';

class BorderlessInput extends StatefulWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final TextInputType type;

  const BorderlessInput({
    Key key,
    @required this.hint,
    this.obscure = false,
    @required this.controller,
    @required this.type, 
  }) : super(key: key);

  @override
  _BorderlessInputState createState() => _BorderlessInputState();
}

class _BorderlessInputState extends State<BorderlessInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        textAlign: TextAlign.center,
        controller: widget.controller,
        obscureText: widget.obscure,
        keyboardType: widget.type,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          hintStyle: ApplicationTypography.borderlessInputHint
        ),
        style: ApplicationTypography.borderlessInput
      ),
    );
  }
}
