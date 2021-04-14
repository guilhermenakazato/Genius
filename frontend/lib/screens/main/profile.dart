import 'package:flutter/material.dart';

import '../../utils/application_colors.dart';
import '../../utils/navigator_util.dart';
import '../../components/gradient_button.dart';
import '../../components/circle_tab_indicator.dart';
import '../../models/user.dart';
import '../../utils/application_typography.dart';
import 'edit_options.dart';
import 'follows.dart';

class Profile extends StatefulWidget {
  final User user;

  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _tags = ['girls', 'flutter', 'matemática', 'ciências da saúde'];
  final _navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/sem-foto.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 170,
                      child: Text(
                        widget.user.username,
                        style: ApplicationTypography.profileName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 17,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.user.local,
                              style: ApplicationTypography.profileCity,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
              top: 8,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _navigator.navigate(
                        context,
                        Follows(
                          user: widget.user,
                        ));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '17K',
                          style: ApplicationTypography.numberFollowProfile,
                        ),
                        Text(
                          'seguidores',
                          style:
                              ApplicationTypography.numberFollowCaptionProfile,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 0.2,
                  height: 22,
                ),
                InkWell(
                  onTap: () {
                    _navigator.navigate(
                        context,
                        Follows(
                          user: widget.user,
                        ));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '387',
                          style: ApplicationTypography.numberFollowProfile,
                        ),
                        Text(
                          'seguindo',
                          style:
                              ApplicationTypography.numberFollowCaptionProfile,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 0.2,
                  height: 22,
                ),
                GradientButton(
                  onPressed: () {
                    _navigator.navigate(context, EditOptions());
                  },
                  text: 'Editar',
                  width: 72,
                  height: 32,
                ),
              ],
            ),
          ),
          Container(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tags.length,
              itemBuilder: (BuildContext context, int index) {
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
                          _tags[index],
                          style: ApplicationTypography.profileTags,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          print(notification);
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.62,
          builder: (context, scrollController) {
            return Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: ApplicationColors.cardColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 33,
                          right: 25,
                          left: 25,
                        ),
                        child: Text(
                          'MY MIND',
                          style: ApplicationTypography.profileInfoTitle,
                        ),
                      ),
                      DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            TabBar(
                              indicator: CircleTabIndicator(
                                color: Colors.white,
                                radius: 3,
                              ),
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Sobre mim',
                                    style: ApplicationTypography
                                        .profileInfoPageTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Meus projetos',
                                    style: ApplicationTypography
                                        .profileInfoPageTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Conquistas',
                                    style: ApplicationTypography
                                        .profileInfoPageTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Questionários',
                                    style: ApplicationTypography
                                        .profileInfoPageTitle,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 300,
                              child: TabBarView(
                                children: <Widget>[
                                  Center(child: Text('oi')),
                                  Center(child: Text('oi')),
                                  Center(child: Text('oi')),
                                  Center(child: Text('oi')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
