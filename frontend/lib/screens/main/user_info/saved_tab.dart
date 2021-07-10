import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';

import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../components/data_not_found_card.dart';
import '../../../models/project.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../utils/navigator_util.dart';
import '../profile.dart';

class SavedTab extends StatefulWidget {
  final List<Project> savedProjects;
  final User follower;

  SavedTab({Key key, @required this.savedProjects, @required this.follower}) : super(key: key);

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

  Widget _determineWhichWidgetsShouldBeDisplayed(BuildContext context) {
    if (widget.savedProjects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8),
        child: DataNotFoundCard(
          color: ApplicationColors.secondCardColor,
          text:
              'Parece que você ainda não salvou nenhum projeto. Que tal navegar pelo feed e salvar um? :)',
        ),
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
          itemCount: widget.savedProjects.length,
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
        cardDirection: Axis.vertical,
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
            onParticipantsClick: (int id) {
              navigator.navigate(
                context,
                Profile(
                  type: 'user',
                  id: id,
                ),
              );
            },
            cardColor: ApplicationColors.secondCardColor,
            abstractText: widget.savedProjects[index].abstractText,
            projectName: widget.savedProjects[index].name,
            type: 'saved_projects',
            projectParticipants: widget.savedProjects[index].participants,
          );
        },
        itemCount: widget.savedProjects.length,
      ),
    );
  }
}
