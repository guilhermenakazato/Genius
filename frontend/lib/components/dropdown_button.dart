import 'package:flutter/material.dart';
import '../utils/application_typography.dart';

class DropDownButton extends StatefulWidget {
  final List<String> items;
  final double width;
  final String hint;
  final void Function(String) onValueChanged;

  const DropDownButton({
    Key key,
    @required this.items,
    this.width,
    this.hint,
    @required this.onValueChanged,
  }) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState(hint);
}

class _DropDownButtonState extends State<DropDownButton> {
  String value;

  _DropDownButtonState(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 24,
        underline: Container(),
        onChanged: (String newValue) {
          setState(() {
            value = newValue;
          });

          _handleSelectedItemChange(newValue);
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(value, style: ApplicationTypography.dropdownButton),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handleSelectedItemChange(String value) {
    widget.onValueChanged(value);
  }
}
