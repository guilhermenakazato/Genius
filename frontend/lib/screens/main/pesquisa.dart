import 'package:flutter/material.dart';
import 'package:genius/components/search_bar.dart';
import 'package:genius/components/tag_bar.dart';

class Pesquisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16),
            child: SearchBar(),
          ),
          TagBar(),
        ],
      ),
    );
  }
}
