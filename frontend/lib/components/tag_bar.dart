import 'package:flutter/material.dart';

import 'tag.dart';

class TagBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Tag(
              text: 'Ciência da Computação',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Tag(
              text: 'Ciências Biológicas',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Tag(
              text: 'Inteligencia Artificial',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Tag(
              text: 'Girls',
            ),
          ),
        ],
      ),
    );
  }
}
