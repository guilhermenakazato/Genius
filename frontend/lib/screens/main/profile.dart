import 'package:flutter/material.dart';

import '../../utils/application_colors.dart';
import '../../components/gradient_button.dart';
import '../../models/user.dart';
import '../../utils/application_typography.dart';

class Profile extends StatefulWidget {
  final User user;

  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _tags = ['girls', 'flutter', 'matemática', 'ciências da saúde'];
  final _pages = ['Sobre mim', 'Meus projetos', 'Conquistas', 'Questionários'];

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Text(
                    widget.user.username,
                    style: ApplicationTypography.profileName,
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
                          child: Text(widget.user.local,
                              style: ApplicationTypography.profileCity),
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
            top: 15,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '17K',
                    style: ApplicationTypography.numberFollowProfile,
                  ),
                  Text(
                    'followers',
                    style: ApplicationTypography.numberFollowCaptionProfile,
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: 0.2,
                height: 22,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '387',
                    style: ApplicationTypography.numberFollowProfile,
                  ),
                  Text(
                    'following',
                    style: ApplicationTypography.numberFollowCaptionProfile,
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: 0.2,
                height: 22,
              ),
              GradientButton(
                onPressed: () {},
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
                      child: Text(_tags[index],
                          style: ApplicationTypography.profileTags),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: ApplicationColors.cardColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(34),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 33, right: 25, left: 25),
                  child: Text('MY MIND',
                      style: ApplicationTypography.profileInfoTitle),
                ),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 13.0,
                          top: 3,
                          left: 13,
                        ),
                        child: _determineActiveListViewItem(index),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _determineActiveListViewItem(int index) {
    if (index == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              _pages[index],
              style: ApplicationTypography.selectedProfileInfoPageTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CircleAvatar(
              radius: 2,
              backgroundColor: Colors.white,
            ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          _pages[index],
          style: ApplicationTypography.notSelectedProfileInfoPageTitle,
        ),
      );
    }
  }
}
