import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onChange;

  const SearchBar({Key key, this.onChange}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _determineSize(context),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: ApplicationColors.searchFieldColor,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.5),
              child: _returnTextFieldIfNotFolded(),
            ),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: ApplicationColors.searchButtonColor,
            ),
            duration: Duration(milliseconds: 200),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_determineBorderRadius()),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_determineBorderRadius()),
                  bottomRight: Radius.circular(32),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.5),
                  child: Icon(
                    _determineIcon(),
                    color: ApplicationColors.searchFieldIconColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  double _determineSize(BuildContext context) {
    if (_folded) {
      return 45;
    } else {
      return MediaQuery.of(context).size.width * 0.95;
    }
  }

  double _determineBorderRadius() {
    if (_folded) {
      return 32;
    } else {
      return 0;
    }
  }

  IconData _determineIcon() {
    if (_folded) {
      return Icons.search;
    } else {
      return Icons.close;
    }
  }

  Widget _returnTextFieldIfNotFolded() {
    if (!_folded) {
      return TextField(
        style: ApplicationTypography.searchField,
        onChanged: (value) {
          _handleChange(value);
        },
        cursorColor: ApplicationColors.primary,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Pesquisar',
          hintStyle: ApplicationTypography.searchFieldHint,
          border: InputBorder.none,
        ),
      );
    } else {
      return null;
    }
  }

  void _handleChange(String value) {
    widget.onChange(value);
  }
}
