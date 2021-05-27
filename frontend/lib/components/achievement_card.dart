import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../models/achievement.dart';
import 'borderless_button.dart';

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
                _determineCardType(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _determineCardType() {
    switch (achievement.type) {
      case 'Medalha':
        return _medalCard();
        break;
      case 'Certificado':
        return _certificateCard();
        break;
      case 'Honra ao mérito':
        return _honorCard();
        break;
      case 'Outro':
        return _otherTypeCard();
        break;
      default:
        return Container();
    }
  }

  Widget _medalCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.grade_outlined, size: 70)],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Medalha • ${achievement.name} • ${achievement.institution} ${_returnPositionIfExists()}',
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _certificateCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              'Certificado • ${achievement.name} • ${achievement.institution}',
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _honorCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              'Honra ao Mérito • ${achievement.name} • ${achievement.institution}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherTypeCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              '${achievement.customizedType} • ${achievement.name} • ${achievement.institution} ${_returnPositionIfExists()}',
            ),
          ),
        ],
      ),
    );
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
