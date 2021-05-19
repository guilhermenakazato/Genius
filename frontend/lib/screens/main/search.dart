import 'package:flutter/material.dart';

import '../../components/search_bar.dart';
import '../../components/tag_bar.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10),
            child: SearchBar(),
          ),
          TagBar(),
        ],
      ),
    );
  }
}
