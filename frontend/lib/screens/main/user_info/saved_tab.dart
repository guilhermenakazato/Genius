import 'package:flutter/material.dart';

import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../components/data_not_found_card.dart';
import '../../../models/project.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../utils/application_typography.dart';
import '../../../utils/navigator_util.dart';

class SavedTab extends StatefulWidget {
  final List<Project> savedProjects;

  SavedTab({Key key, @required this.savedProjects}) : super(key: key);

  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final navigator = NavigatorUtil();
  bool card = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_determineWhichWidgetsShouldBeDisplayed(context)],
      ),
    );
  }

  dynamic _determineWhichWidgetsShouldBeDisplayed(BuildContext context) {
    if (widget.savedProjects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8),
        child: DataNotFoundCard(
            color: ApplicationColors.secondCardColor,
            text:
                'Parece que você ainda não salvou nenhum projeto. Que tal navegar pelo feed e salvar um? :)'),
      );
    } else {
      return [
        _iconToChooseStyleOfProjects(),
        _determineWhichLayoutShouldBeDisplayed(context)
      ];
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
          itemCount: widget.savedProjects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Container(
                height: 50,
                child: Card(
                  child: Ink(
                    color: ApplicationColors.secondCardColor,
                    child: InkWell(
                      onTap: () {
                        navigator.navigate(
                          context,
                          ProjectInfo(
                            project: widget.savedProjects[index],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          widget.savedProjects[index].name,
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
      height: 500,
      child: GeniusCardConfig(
        builder: (BuildContext context, int index) {
          return GeniusCard(
            onTap: () {
              navigator.navigate(
                context,
                ProjectInfo(
                  project: widget.savedProjects[index],
                ),
              );
            },
            cardColor: ApplicationColors.searchButtonColor,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _projectName(index),
                  _participantsOfTheProject(index),
                  _abstractText(index),
                ],
              ),
            ],
          );
        },
        itemsToCount: widget.savedProjects,
      ),
    );
  }

  Widget _projectName(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
      ),
      child: Container(
        width: double.infinity,
        child: Text(
          widget.savedProjects[index].name,
          style: ApplicationTypography.cardTitle,
        ),
      ),
    );
  }

  Widget _abstractText(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        40,
        10,
        30,
        0,
      ),
      child: Text(
        widget.savedProjects[index].abstractText,
        style: ApplicationTypography.cardText,
      ),
    );
  }

  Widget _participantsOfTheProject(int index) {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.savedProjects[index].participants.length,
        itemBuilder: (BuildContext context, int participantIndex) {
          return Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: ApplicationColors.cardColor,
                    width: 3,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 13.0,
                    bottom: 5,
                    right: 20,
                    left: 20,
                  ),
                  child: Text(
                    widget.savedProjects[index].participants[participantIndex]
                        .username,
                    style: ApplicationTypography.profileTags,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
