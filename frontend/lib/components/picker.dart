import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/application_typography.dart';

class Picker extends StatefulWidget {
  final void Function(int) onChanged;
  final int initialValue;

  const Picker({Key key, @required this.onChanged, this.initialValue = 0}) : super(key: key);

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  int _age;
  final _ages = [for (var i = 10; i <= 70; i++) i];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: widget.initialValue),
        itemExtent: 51,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: (int value) {
          _age = value;
          _handleValueChange(_age);
        },
        children: <Widget>[
          for (var number in _ages)
            Center(
              child: Text(
                number.toString(),
                style: ApplicationTypography.primarySignUpText,
              ),
            ),
        ],
      ),
    );
  }

  void _handleValueChange(int value) {
    widget.onChanged(value);
  }
}
