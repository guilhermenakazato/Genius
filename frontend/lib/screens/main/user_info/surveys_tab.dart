import 'package:flutter/material.dart';
import '../../../utils/application_colors.dart';

import '../../../models/survey.dart';

class SurveysTab extends StatefulWidget {
  final List<Survey> surveys;

  SurveysTab({Key key, @required this.surveys}) : super(key: key);

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
          SizedBox(
            width: 300,
            height: 450,
            child: Card(
              elevation: 0,
              color: ApplicationColors.secondCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Center(
                    child: Text(
                      'Parece que você ainda não criou nenhum questionário. Que tal criar um? :) Eles são ótimos para coleta de dados!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(height: 70),
        ],
      );
    } else {
      _listOfSurveys();
    }
  }

  Widget _listOfSurveys() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8),
          child: ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isOpen[index] = !isExpanded;
              });
            },
            children:
                widget.surveys.asMap().entries.map<ExpansionPanel>((entry) {
              return ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: ApplicationColors.secondCardColor,
                isExpanded: isOpen[entry.key],
                body: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, bottom: 8, top: 8),
                    child:
                        Text('Link do seu questionário: ${entry.value.link}'),
                  ),
                ),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(entry.value.name),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
