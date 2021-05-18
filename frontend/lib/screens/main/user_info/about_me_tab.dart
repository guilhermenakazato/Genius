import 'package:flutter/material.dart';

import '../../../utils/application_typography.dart';
import '../../../models/user.dart';

class AboutMeTab extends StatelessWidget {
  final User user;

  const AboutMeTab({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _determineWhichIconShouldBeDisplayed(),
                ),
                Container(
                  child: Text(
                    user.type,
                    textAlign: TextAlign.start,
                    style: ApplicationTypography.aboutMeText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.work),
                ),
                Container(
                  child: Text(
                    user.institution,
                    textAlign: TextAlign.start,
                    style: ApplicationTypography.aboutMeText,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.school),
                  ),
                  Container(
                    child: Text(
                      user.formation,
                      textAlign: TextAlign.start,
                      style: ApplicationTypography.aboutMeText,
                    ),
                  ),
                ],
              ),
            ),
            _bio(),
          ],
        ),
      ),
    );
  }

  Widget _bio() {
    if (user.bio.isNotEmpty && user.bio != null) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Divider(
              color: Colors.white,
              height: 15,
              thickness: 2,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              user.bio,
              textAlign: TextAlign.start,
              style: ApplicationTypography.aboutMeText,
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _determineWhichIconShouldBeDisplayed() {
    if (user.type == 'Estudante') {
      return Icon(Icons.sticky_note_2);
    } else {
      return Icon(Icons.square_foot);
    }
  }
}
