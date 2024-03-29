import 'package:flutter/material.dart';

import '../../../components/achievement_card.dart';
import '../../../components/data_not_found_card.dart';
import '../../../utils/application_colors.dart';
import '../../../models/achievement.dart';

class AchievementsTab extends StatelessWidget {
  final List<Achievement> achievements;
  final String notFoundText;

  const AchievementsTab({Key key, @required this.achievements, this.notFoundText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_determineWhichWidgetsShouldBeDisplayed(context)],
      ),
    );
  }

  Widget _determineWhichWidgetsShouldBeDisplayed(BuildContext context) {
    if (achievements.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8),
        child: DataNotFoundCard(
          color: ApplicationColors.secondCardColor,
          text: notFoundText,
        ),
      );
    } else {
      return SizedBox(
        height: 500,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return AchievementCard(
                  color: ApplicationColors.secondCardColor,
                  achievement: achievements[index],
                );
              }),
        ),
      );
    }
  }
}
