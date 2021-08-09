import 'package:flutter/material.dart';
import '../utils/application_typography.dart';

class TeamDescription extends StatelessWidget {
  final String name;
  final String photoPath;
  const TeamDescription({
    Key key,
    @required this.name,
    @required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(photoPath),
          ),
        ),
        Text(
          name,
          style: ApplicationTypography.aboutTeam,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
