import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/application_colors.dart';
import '../models/achievement.dart';
import 'borderless_button.dart';
import 'warning_dialog.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({Key key, this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: BorderlessButton(
                      onPressed: () {},
                      text: 'Excluir',
                      color: ApplicationColors.atentionColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: BorderlessButton(
                      onPressed: () {},
                      text: 'Editar',
                      color: ApplicationColors.editButtonColor,
                    ),
                  ),
                ],
              ),
            ],
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
    return Column(
      children: <Widget>[
        Text(
          'Tipo da conquista: medalha',
        ),
        Text('Nome da conquista: ${achievement.name}'),
        Text('Instituição da conquista: ${achievement.institution}'),
        _returnPositionIfExists(),
      ],
    );
  }

  Widget _certificateCard() {
    return Column(
      children: <Widget>[
        Text(
          'Tipo da conquista: Certificado',
        ),
        Text('Nome da conquista: ${achievement.name}'),
        Text('Instituição da conquista: ${achievement.institution}'),
      ],
    );
  }

  Widget _honorCard() {
    return Column(
      children: <Widget>[
        Text(
          'Tipo da conquista: Honra ao Mérito',
        ),
        Text('Nome da conquista: ${achievement.name}'),
        Text('Instituição da conquista: ${achievement.institution}'),
      ],
    );
  }

  Widget _otherTypeCard() {
    return Column(
      children: <Widget>[
        Text(
          'Tipo da conquista: ${achievement.customizedType}',
        ),
        Text('Nome da conquista: ${achievement.name}'),
        Text('Instituição da conquista: ${achievement.institution}'),
        _returnPositionIfExists(),
      ],
    );
  }

  Widget _returnPositionIfExists() {
    if (achievement.position != null) {
      if (achievement.position.isNotEmpty) {
        return Text('Posição: ${achievement.position}');
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
