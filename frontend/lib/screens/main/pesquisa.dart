import 'package:flutter/material.dart';
import 'package:genius/components/search_bar.dart';

class Pesquisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16),
            child: SearchBar(),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: Chip(
                    label: Text('Ciências da Computação'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 5, 5, 5),
                  child: Chip(
                    label: Text('Girls'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: Chip(
                    label: Text('Ciências da Computação'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 5, 5, 5),
                  child: Chip(
                    label: Text('Girls'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
