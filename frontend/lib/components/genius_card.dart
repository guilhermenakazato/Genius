import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class GeniusCard extends StatelessWidget {
  final Function onTap;
  final Color cardColor;
  final String type;
  final String projectName;
  final String abstractText;
  final List<User> projectParticipants;
  final Function onEdit;
  final int deleteRequestsCount;
  final int participantsCount;

  const GeniusCard({
    Key key,
    @required this.onTap,
    @required this.cardColor,
    @required this.type,
    @required this.projectName,
    @required this.abstractText,
    @required this.projectParticipants,
    this.onEdit,
    this.deleteRequestsCount,
    this.participantsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: cardColor,
          ),
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _projectName(),
                      _participantsOfTheProject(),
                      _abstractText(),
                    ],
                  ),
                  _defineButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defineButtons(BuildContext context) {
    if (type == 'edit') {
      return _editButtons(context);
    } else if (type == 'saved_projects') {
      return Container();
    } else if (type == 'feed') {
      return _feedButtons();
    } else {
      return Container();
    }
  }

  Widget _projectName() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
      ),
      child: Container(
        width: double.infinity,
        child: Text(
          projectName,
          style: ApplicationTypography.cardTitle,
        ),
      ),
    );
  }

  Widget _abstractText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        40,
        10,
        30,
        0,
      ),
      child: Container(
        width: double.infinity,
        child: Text(
          abstractText,
          style: ApplicationTypography.cardText,
        ),
      ),
    );
  }

  Widget _participantsOfTheProject() {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projectParticipants.length,
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
                    projectParticipants[index].username,
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

  Widget _editButtons(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: ApplicationColors.iconButtonColor,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      onEdit();
                    },
                    child: Icon(
                      Icons.edit_outlined,
                      color: ApplicationColors.editButtonColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(12),
                    backgroundColor: ApplicationColors.iconButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.close_outlined,
                          color: ApplicationColors.atentionColor,
                        ),
                      ),
                      Text(
                        '$deleteRequestsCount/$participantsCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Gotham',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feedButtons() {
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
