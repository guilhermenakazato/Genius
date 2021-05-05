import 'package:flutter/material.dart';

import '../../../models/user.dart';

class AboutMeTab extends StatelessWidget {
  final User user;

  const AboutMeTab({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              user.username,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.email,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.type,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.age,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.local,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.institution,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.formation,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
