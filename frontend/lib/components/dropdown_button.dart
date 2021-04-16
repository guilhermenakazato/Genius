import 'package:flutter/material.dart';
import '../utils/application_typography.dart';

class DropDownButton extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final double width;

  const DropDownButton({
    Key key,
    @required this.items,
    this.initialValue, this.width,
  }) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState(initialValue);
}

class _DropDownButtonState extends State<DropDownButton> {
  String value;

  _DropDownButtonState(this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
      ),
    );
  }
}
