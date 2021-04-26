import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
          debugPrint(snapshot.data);

          return _FeedContent(
            projects: snapshot.data,
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
  final String projects;

  const _FeedContent({Key key, this.projects}) : super(key: key);

  @override
  _FeedState createState() => _FeedState(projects);
}

class _FeedState extends State<_FeedContent> {
  final navigator = NavigatorUtil();
  final String projects;

  _FeedState(this.projects);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Swiper(
          itemCount: 100,
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
                          number: index + 1,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Projeto ' + (index + 1).toString(),
                                    style: ApplicationTypography.cardTitle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 30, 0),
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in[...]',
                                  style: ApplicationTypography.cardText,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon:
                                          const Icon(Icons.volunteer_activism),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
