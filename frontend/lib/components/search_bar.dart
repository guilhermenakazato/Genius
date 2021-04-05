import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _determineSize(),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: ApplicationColors.searchFieldColor,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: _returnTextFieldIfNotFolded(),
            ),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
            duration: Duration(milliseconds: 400),
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
                  padding: const EdgeInsets.all(16.0),
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

  double _determineSize() {
    if (_folded) {
      return 56;
    } else {
      return 324;
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
}
