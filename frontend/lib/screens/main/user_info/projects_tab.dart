import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../utils/navigator_util.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../utils/application_typography.dart';
import '../../../models/project.dart';

class ProjectsTab extends StatefulWidget {
  final List<Project> projects;

  ProjectsTab({Key key, @required this.projects}) : super(key: key);

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

  dynamic _determineWhichWidgetsShouldBeDisplayed(BuildContext context) {
    if (widget.projects.isEmpty) {
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
                      'Parece que você ainda não criou nenhum projeto. Que tal criar um para divulgar seus projetos incríveis? :)',
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
          itemCount: widget.projects.length,
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
      height: 500,
      child: Swiper(
        scrollDirection: Axis.vertical,
        itemCount: widget.projects.length,
        itemWidth: 300,
        itemHeight: 500,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ApplicationColors.secondCardColor,
                ),
                child: InkWell(
                  onTap: () {
                    navigator.navigate(
                      context,
                      ProjectInfo(
                        project: widget.projects[index],
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            _projectName(index),
                            _participantsOfTheProject(index),
                            _abstractText(index),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
          widget.projects[index].name,
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
        widget.projects[index].abstractText,
        style: ApplicationTypography.cardText,
      ),
    );
  }

  Widget _participantsOfTheProject(int index) {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.projects[index].participants.length,
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
                    widget.projects[index].participants[participantIndex]
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
