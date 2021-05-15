import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../utils/convert.dart';
import '../../models/project.dart';
import '../../http/webclients/project_webclient.dart';
import '../../utils/application_colors.dart';
import '../../utils/application_typography.dart';
import '../../utils/navigator_util.dart';
import 'project/project_info.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProjects(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          var projects =
              Convert.convertStringToListofTypeProject(snapshot.data);

          return _FeedContent(
            projects: projects,
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Future<String> getProjects() async {
    final _webClient = ProjectWebClient();
    final projects = await _webClient.getAllProjects();

    return projects;
  }
}

class _FeedContent extends StatefulWidget {
  final List<Project> projects;

  const _FeedContent({Key key, this.projects}) : super(key: key);

  @override
  _FeedState createState() => _FeedState(projects);
}

class _FeedState extends State<_FeedContent> {
  final navigator = NavigatorUtil();
  final List<Project> projects;

  _FeedState(this.projects);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _verifyWhichWidgetShouldBeDisplayed(),
      ),
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed() {
    if (projects.isEmpty) {
      return _noProjectWidget();
    } else {
      return _carouselOfCards();
    }
  }

  Widget _noProjectWidget() {
    return Container();
  }

  Widget _carouselOfCards() {
    return Swiper(
      itemCount: projects.length,
      layout: SwiperLayout.STACK,
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
                color: Theme.of(context).cardColor,
              ),
              child: InkWell(
                onTap: () {
                  navigator.navigate(
                    context,
                    ProjectInfo(
                      project: projects[index],
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
                      _buttons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
          projects[index].name,
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
        projects[index].abstractText,
        style: ApplicationTypography.cardText,
      ),
    );
  }

  Widget _participantsOfTheProject(int index) {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects[index].participants.length,
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
                    projects[index].participants[participantIndex].username,
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

  Widget _buttons() {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.volunteer_activism,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
