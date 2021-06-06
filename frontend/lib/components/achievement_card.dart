import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../models/achievement.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({Key key, this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10),
      child: SizedBox(
        width: 350,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.grade_outlined, size: 70),
                    Expanded(
                      child: Text(
                        _determineCardText(),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                            ),
                            onPressed: () {},
                            color: ApplicationColors.editButtonColor,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close_outlined,
                            ),
                            onPressed: () {},
                            color: ApplicationColors.atentionColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _determineCardText() {
    switch (achievement.type) {
      case 'Medalha':
        return _medalText();
        break;
      case 'Certificado':
        return _certificateText();
        break;
      case 'Honra ao mérito':
        return _honorText();
        break;
      case 'Outro':
        return _otherTypeText();
        break;
      default:
        return '';
    }
  }

  String _medalText() {
    return 'Medalha • ${achievement.name} • ${achievement.institution} ${_returnPositionIfExists()}';
  }

  String _certificateText() {
    return 'Certificado • ${achievement.name} • ${achievement.institution}';
  }

  String _honorText() {
    return 'Honra ao Mérito • ${achievement.name} • ${achievement.institution}';
  }

  String _otherTypeText() {
    return '${achievement.customizedType} • ${achievement.name} • ${achievement.institution} ${_returnPositionIfExists()}';
  }

  String _returnPositionIfExists() {
    if (achievement.position != null) {
      if (achievement.position.isNotEmpty) {
        return '• ${achievement.position}';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}
