import 'package:flutter/material.dart';

class InputWithAnimation extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;
  final TextInputType type;
  final String Function(String) validator;
  final IconData suffixIcon;
  final Function onSuffixIconPress;
  final Function onTap;
  final bool readonly;
  final FocusNode node;
  final bool allowMultilines;
  final int maxChar;

  const InputWithAnimation({
    Key key,
    @required this.controller,
    this.label,
    this.icon,
    this.obscure = false,
    @required this.type,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPress,
    this.onTap,
    this.readonly = false,
    this.node,
    this.allowMultilines = false,
    this.maxChar,
  }) : super(key: key);

  int _verifyIfMultiLinesIsAllowed() {
    if (allowMultilines) {
      return null;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: _verifyIfMultiLinesIsAllowed(),
      maxLength: maxChar,
      validator: validator,
      focusNode: node,
      autofocus: false,
      readOnly: readonly,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      textCapitalization: TextCapitalization.words,
      obscureText: obscure,
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(22, 20, 22, 20),
        prefixIcon: _determineIfPrefixIconShouldAppear(context),
        suffixIcon: _determineIfSuffixIconShouldAppear(context),
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      keyboardType: type,
    );
  }

  Icon _determineIfPrefixIconShouldAppear(BuildContext context) {
    if (icon != null) {
      return Icon(
        icon,
        color: Theme.of(context).primaryColor,
      );
    }

    return null;
  }

  Widget _determineIfSuffixIconShouldAppear(BuildContext context) {
    if (suffixIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            onSuffixIconPress();
          },
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    return null;
  }
}
