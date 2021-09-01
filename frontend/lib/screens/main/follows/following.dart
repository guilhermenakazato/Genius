import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/genius_toast.dart';
import '../../../components/gradient_button.dart';
import '../../../models/user.dart';
import '../../../utils/navigator_util.dart';
import '../../../utils/application_colors.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/jwt_token.dart';
import '../../../utils/application_typography.dart';
import '../profile.dart';

class Following extends StatefulWidget {
  final Function onChangedState;
  final String type;
  final int id;

  const Following(
      {Key key, this.onChangedState, @required this.type, @required this.id})
      : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  Future<String> _userData;
  final _tokenObject = JwtToken();
  final _navigator = NavigatorUtil();

  @override
  void initState() {
    super.initState();
    _userData = _defineHowToGetData();
  }

  Future<String> _defineHowToGetData() {
    if (widget.type == 'edit') {
      return _getDataByToken();
    } else {
      return _getDataById();
    }
  }

  Future<String> _getDataByToken() async {
    final webClient = UserWebClient();
    final jwtToken = await _tokenObject.getToken();
    final user = await webClient.getUserData(jwtToken);
    return user;
  }

  Future<String> _getDataById() async {
    final webClient = UserWebClient();
    final jwtToken = await _tokenObject.getToken();

    final user = await webClient.getUserById(widget.id, jwtToken);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: ApplicationColors.splashColor,
      ),
      child: Scaffold(
        body: ProgressHUD(
          borderColor: Theme.of(context).primaryColor,
          indicatorWidget: SpinKitPouringHourglass(
            color: Theme.of(context).primaryColor,
          ),
          child: Builder(
            builder: (context) {
              return FutureBuilder(
                future: _userData,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    final user = User.fromJson(jsonDecode(snapshot.data));

                    if (user.following.isEmpty) {
                      return Align(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Column(
                            children: [
                              Container(
                                width: 310.0,
                                height: 250.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      'assets/not_found.png',
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _determineNotFoundText(),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 8.0),
                        itemCount: user.following.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: _determineRadius(
                                  index,
                                  user.following.length,
                                ),
                                color: ApplicationColors.searchResultColor,
                              ),
                              child: InkWell(
                                borderRadius: _determineRadius(
                                  index,
                                  user.following.length,
                                ),
                                onTap: () {
                                  _navigator.navigateAndReload(
                                    context,
                                    Profile(
                                      type: 'follows',
                                      id: user.following[index].id,
                                    ),
                                    () {
                                      widget.onChangedState();
                                      setState(() {
                                        _userData = _getDataByToken();
                                      });
                                    },
                                  );
                                },
                                splashColor: Colors.white24,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8,
                                    right: 8,
                                    left: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                user.following[index].username,
                                                style: ApplicationTypography
                                                    .mentionStyle,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                user.following[index].name,
                                                style: ApplicationTypography
                                                    .mentionFullNameStyle,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _verifyIfButtonShouldAppear(
                                        user,
                                        index,
                                        context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return SpinKitFadingCube(color: ApplicationColors.primary);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void unfollow(User user, User follower, BuildContext context) async {
    final webClient = UserWebClient();
    var unfollowed = true;
    final progress = ProgressHUD.of(context);
    final jwtToken = await _tokenObject.getToken();

    progress.show();

    await webClient.unfollow(user.id, follower.id, false, jwtToken).catchError(
        (error) {
      unfollowed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível deixar de seguir o usuário.');
    }, test: (error) => error is TimeoutException);

    if (unfollowed) {
      progress.dismiss();
      setState(() {
        _userData = _getDataByToken();
      });
    }
  }

  Widget _verifyIfButtonShouldAppear(
    User user,
    int position,
    BuildContext context,
  ) {
    if (widget.type == 'edit') {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GradientButton(
          onPressed: () {
            widget.onChangedState();
            unfollow(
              user.following[position],
              user,
              context,
            );
          },
          text: 'Seguindo',
          width: 90,
          height: 32,
        ),
      );
    } else {
      return Container();
    }
  }

  BorderRadius _determineRadius(int index, int listSize) {
    if (listSize == 1) {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      );
    } else if (index == listSize - 1) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else {
      return BorderRadius.circular(0);
    }
  }

  String _determineNotFoundText() {
    if (widget.type == 'edit') {
      return 'Você ainda não está seguindo ninguém.';
    } else {
      return 'Esse usuário ainda não está seguindo ninguém.';
    }
  }
}
