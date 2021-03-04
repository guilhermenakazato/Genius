import 'package:flutter/material.dart';
import 'package:genius/components/search_bar.dart';

class Pesquisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 16),
          child: SearchBar(),
        ),
      ],
    );
  }
}
