import 'package:flutter/material.dart';

import '../utils/application_colors.dart';

class Tag extends StatefulWidget {
  final String text;
  final void Function(bool) onSelected;
  final bool isSelected;

  const Tag({Key key, @required this.text, this.onSelected, this.isSelected})
      : super(key: key);

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.text),
      selected: _selected,
      elevation: 0,
      backgroundColor: ApplicationColors.unselectedTagColor,
      selectedColor: ApplicationColors.selectedTagColor,
      onSelected: (bool value) {
        setState(() {
          _selected = value;
        });

        _handleTagSelected(value);
      },
    );
  }

  void _handleTagSelected(bool value) {
    widget.onSelected(value);
  }
}
