import 'package:flutter/material.dart';

import 'tag.dart';

class TagBar extends StatefulWidget {
  final List<dynamic> tags;
  final int tagsCount;
  final Function(int position, bool value) onChangedState;

  const TagBar({Key key, @required this.tags, this.onChangedState, @required this.tagsCount})
      : super(key: key);

  @override
  State<TagBar> createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List<bool>.filled(widget.tags.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 5),
        itemCount: widget.tagsCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Tag(
              text: widget.tags[position],
              isSelected: _isSelected[position],
              onSelected: (bool value) {
                setState(() {
                  _isSelected[position] = value;
                });

                _handleTagSelected(position, value);
              },
            ),
          );
        },
      ),
    );
  }

  void _handleTagSelected(int position, bool value) {
    widget.onChangedState(position, value);
  }
}
