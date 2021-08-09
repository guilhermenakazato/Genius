import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../models/user.dart';
import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class GeniusCard extends StatefulWidget {
  final Function onTap;
  final Color cardColor;
  final String type;
  final String projectName;
  final String abstractText;
  final List<User> projectParticipants;
  final Function onEdit,
      onLiked,
      onClickedConversationIcon,
      onSaved,
      onDeleteRequest;
  final int deleteRequestsCount;
  final int participantsCount;
  final Color participantsBorderColor;
  final Function(int id) onParticipantsClick;
  final bool liked, saved;
  final int likes;
  final hasAlreadyRequestedDelete;
  final double textHeight;

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
    this.participantsBorderColor = ApplicationColors.participantsTagColor,
    this.onParticipantsClick,
    this.onLiked,
    this.onClickedConversationIcon,
    this.onSaved,
    this.liked = false,
    this.saved = false,
    this.likes = 0,
    this.onDeleteRequest,
    this.hasAlreadyRequestedDelete = false, @required this.textHeight,
  }) : super(key: key);

  @override
  State<GeniusCard> createState() => _GeniusCardState();
}

class _GeniusCardState extends State<GeniusCard> {
  bool likeIsLoading = false, saveIsLoading = false;

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
            color: widget.cardColor,
          ),
          child: InkWell(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _projectName(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: _participantsOfTheProject(),
                      ),
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
    if (widget.type == 'edit') {
      return _editButtons(context);
    } else if (widget.type == 'saved_projects' ||
        widget.type == 'my_projects') {
      return _myMindProjects(context);
    } else if (widget.type == 'feed') {
      return _feedButtons(context);
    } else {
      return Container();
    }
  }

  Widget _projectName() {
    if (widget.projectName.length >= 14) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: SizedBox(
          width: 250,
          height: 40,
          child: Marquee(
            text: widget.projectName,
            style: ApplicationTypography.cardTitle,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 40.0,
            pauseAfterRound: Duration(seconds: 1),
            showFadingOnlyWhenScrolling: true,
            fadingEdgeStartFraction: 0.1,
            fadingEdgeEndFraction: 0.1,
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
        child: Container(
          width: double.infinity,
          child: Text(
            widget.projectName,
            style: ApplicationTypography.cardTitle,
          ),
        ),
      );
    }
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
        height: widget.textHeight,
        child: Container(
          width: double.infinity,
          child: Text(
            widget.abstractText,
            style: ApplicationTypography.cardText,
          ),
        ),
      ),
    );
  }

  Widget _participantsOfTheProject() {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.projectParticipants.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 10),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.participantsBorderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  _handleParticipantTagClick(
                    widget.projectParticipants[index].id,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.projectParticipants[index].username,
                        style: ApplicationTypography.profileTags,
                      ),
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
                      widget.onEdit();
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
                  onPressed: () {
                    if (widget.onDeleteRequest != null) {
                      widget.onDeleteRequest();
                    }
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _defineDeleteProjectIcon(),
                      ),
                      Text(
                        '${widget.deleteRequestsCount}/${widget.participantsCount}',
                        style: ApplicationTypography.deleteRequestsCardText,
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

  Widget _feedButtons(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Curtido por\n${widget.likes.toString()} pessoas',
                style: ApplicationTypography.like,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 4,
                  right: 4,
                  bottom: 4,
                ),
                child: Container(
                  width: 48,
                  height: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: ApplicationColors.iconButtonColor,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () async {
                      if (widget.onLiked != null) {
                        setState(() {
                          likeIsLoading = true;
                        });

                        await widget.onLiked();

                        setState(() {
                          likeIsLoading = false;
                        });
                      }
                    },
                    child: _defineLikeWidget(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 48,
                  height: 48,
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
                      if (widget.onSaved != null) {
                        widget.onSaved();
                      }
                    },
                    child: _defineSaveWidget(),
                  ),
                ),
              ),
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
                      if (widget.onClickedConversationIcon != null) {
                        widget.onClickedConversationIcon();
                      }
                    },
                    child: Icon(
                      Icons.question_answer_outlined,
                      color: ApplicationColors.editButtonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myMindProjects(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'Curtido por\n${widget.likes.toString()} pessoas',
                    style: ApplicationTypography.like,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 4,
                      right: 4,
                      bottom: 4,
                    ),
                    child: Container(
                      width: 48,
                      height: 48,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          backgroundColor: ApplicationColors.iconButtonColor,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () async {
                          if (widget.onLiked != null) {
                            setState(() {
                              likeIsLoading = true;
                            });

                            await widget.onLiked();

                            setState(() {
                              likeIsLoading = false;
                            });
                          }
                        },
                        child: _defineLikeWidget(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 48,
                  height: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: ApplicationColors.iconButtonColor,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () async {
                      if (widget.onSaved != null) {
                        setState(() {
                          saveIsLoading = true;
                        });

                        await widget.onSaved();

                        setState(() {
                          saveIsLoading = false;
                        });
                      }
                    },
                    child: _defineSaveWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleParticipantTagClick(int userId) {
    widget.onParticipantsClick(userId);
  }

  Widget _defineLikeWidget() {
    if (likeIsLoading) {
      return CircularProgressIndicator();
    } else {
      if (!widget.liked) {
        return Icon(
          Icons.favorite_outline,
          color: ApplicationColors.editButtonColor,
        );
      } else {
        return Icon(
          Icons.favorite_outlined,
          color: Colors.red,
        );
      }
    }
  }

  Widget _defineSaveWidget() {
    if (saveIsLoading) {
      return CircularProgressIndicator();
    } else {
      if (!widget.saved) {
        return Icon(
          Icons.bookmark_outline,
          color: ApplicationColors.editButtonColor,
        );
      } else {
        return Icon(
          Icons.bookmark_outlined,
          color: Colors.white,
        );
      }
    }
  }

  Widget _defineDeleteProjectIcon() {
    if (!widget.hasAlreadyRequestedDelete) {
      return Icon(
        Icons.close_outlined,
        color: ApplicationColors.atentionColor,
      );
    } else {
      return Icon(
        Icons.priority_high,
        color: Colors.orange,
      );
    }
  }
}
