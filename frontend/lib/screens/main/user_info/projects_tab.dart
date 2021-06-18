import 'package:flutter/material.dart';

import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../components/data_not_found_card.dart';
import '../../../utils/navigator_util.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../models/project.dart';

class ProjectsTab extends StatefulWidget {
  final List<Project> projects;
  final String notFoundText;

  ProjectsTab({Key key, @required this.projects, this.notFoundText}) : super(key: key);

  @override
  _ProjectsTabState createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  final navigator = NavigatorUtil();
  bool card = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _determineWhichWidgetsShouldBeDisplayed(context),
        ],
      ),
    );
  }

  Widget _determineWhichWidgetsShouldBeDisplayed(BuildContext context) {
    if (widget.projects.isEmpty) {
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
      return Column(
        children: [
          _iconToChooseStyleOfProjects(),
          _determineWhichLayoutShouldBeDisplayed(context)
        ],
      );
    }
  }

  Widget _iconToChooseStyleOfProjects() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: IconButton(
              splashRadius: 32,
              icon: Icon(_determineWhichIconShouldBeDisplayed()),
              onPressed: () {
                setState(() {
                  card = !card;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _determineWhichIconShouldBeDisplayed() {
    if (card) {
      return Icons.list_alt;
    } else {
      return Icons.view_carousel;
    }
  }

  Widget _determineWhichLayoutShouldBeDisplayed(BuildContext context) {
    if (card) {
      return _carouselOfCards();
    } else {
      return _listOfCards(context);
    }
  }

  Widget _listOfCards(BuildContext context) {
    return SizedBox(
      height: 500,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: widget.projects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Container(
                height: 50,
                child: Card(
                  elevation: 0,
                  child: Ink(
                    color: ApplicationColors.secondCardColor,
                    child: InkWell(
                      onTap: () {
                        navigator.navigate(
                          context,
                          ProjectInfo(
                            project: widget.projects[index],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          widget.projects[index].name,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _carouselOfCards() {
    return SizedBox(
      width: 300,
      height: 455,
      child: GeniusCardConfig(
        cardDirection: Axis.vertical,
        builder: (BuildContext context, int index) {
          return GeniusCard(
            onTap: () {
              navigator.navigate(
                context,
                ProjectInfo(
                  project: widget.projects[index],
                ),
              );
            },
            cardColor: ApplicationColors.secondCardColor,
            projectParticipants: widget.projects[index].participants,
            abstractText: widget.projects[index].abstractText,
            projectName: widget.projects[index].name,
            type: 'my_projects',
            participantsBorderColor:
                ApplicationColors.participantsTagSecondaryColor,
          );
        },
        itemCount: widget.projects.length,
      ),
    );
  }
}
