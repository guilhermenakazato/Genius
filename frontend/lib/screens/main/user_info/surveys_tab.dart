import 'package:flutter/material.dart';

import '../../../components/survey_expandable_card.dart';
import '../../../components/data_not_found_card.dart';
import '../../../utils/application_colors.dart';

import '../../../models/survey.dart';

class SurveysTab extends StatefulWidget {
  final List<Survey> surveys;
  final String notFoundText;

  SurveysTab({Key key, @required this.surveys, this.notFoundText}) : super(key: key);

  @override
  _SurveysTabState createState() => _SurveysTabState();
}

class _SurveysTabState extends State<SurveysTab> {
  List<bool> isOpen;

  @override
  void initState() {
    isOpen = List.filled(widget.surveys.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _determineWhichWidgetShouldBeDisplayed(),
    );
  }

  Widget _determineWhichWidgetShouldBeDisplayed() {
    if (widget.surveys.isEmpty) {
      return Column(
        children: [
          DataNotFoundCard(
            color: ApplicationColors.secondCardColor,
            text: widget.notFoundText,
          ),
          Container(height: 70),
        ],
      );
    } else {
      return _listOfSurveys();
    }
  }

  Widget _listOfSurveys() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8),
          child: SurveyExpandableCard(
            surveys: widget.surveys,
            color: ApplicationColors.secondCardColor,
          ),
        ),
      ],
    );
  }
}
