import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/components/gradient_button.dart';
import 'package:genius/http/webclients/user_webclient.dart';
import 'package:genius/models/token.dart';
import 'package:genius/models/user.dart';
import 'package:genius/utils/application_colors.dart';
import 'package:genius/utils/genius_toast.dart';
import 'package:genius/utils/navigator_util.dart';

import '../../../utils/application_typography.dart';
import '../profile.dart';

class Followers extends StatefulWidget {
  final Function onChangedState;
  final String type;
  final int id;

  const Followers(
      {Key key, this.onChangedState, @required this.type, @required this.id})
      : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  Future<String> _userData;
  final _tokenObject = Token();
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

  Future<String> _getDataById() async {
    final _webClient = UserWebClient();
    final _user = await _webClient.getUserById(widget.id);
    return _user;
  }

  Future<String> _getDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        borderColor: Theme.of(context).primaryColor,
        indicatorWidget: SpinKitPouringHourglass(
          color: Theme.of(context).primaryColor,
        ),
        child: Builder(builder: (context) {
          return FutureBuilder(
            future: _userData,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                final user = User.fromJson(jsonDecode(snapshot.data));

                if (user.followers.isEmpty) {
                  return Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _determineNotFoundText(),
                          style: ApplicationTypography.testText,
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0),
                    itemCount: user.followers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _navigator.navigateAndReload(
                            context,
                            Profile(
                              type: 'follows',
                              id: user.followers[index].id,
                              follower: user,
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 120,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        user.followers[index].username,
                                        style:
                                            ApplicationTypography.mentionStyle,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        user.followers[index].name,
                                        style: ApplicationTypography
                                            .mentionFullNameStyle,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _verifyIfButtonShouldAppear(user, index, context),
                            ],
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
        }),
      ),
    );
  }

  Widget _verifyIfButtonShouldAppear(
      User user, int position, BuildContext context) {
    if (widget.type == 'edit') {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GradientButton(
          onPressed: () {
            widget.onChangedState();
            removeFollower(
              user,
              user.followers[position],
              context,
            );
          },
          text: 'Remover',
          width: 90,
          height: 32,
        ),
      );
    } else {
      return Container();
    }
  }

  void removeFollower(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    var unfollowed = true;
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.unfollow(user.id, follower.id, true).catchError((error) {
      unfollowed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível remover o usuário.');
    }, test: (error) => error is TimeoutException);

    if (unfollowed) {
      progress.dismiss();
      setState(() {
        _userData = _getDataByToken();
      });
    }
  }

  String _determineNotFoundText() {
    if (widget.type == 'edit') {
      return 'Você ainda não está sendo seguido por ninguém';
    } else {
      return 'Esse usuário ainda não está sendo seguido por ninguém. Que tal seguí-lo?';
    }
  }
}
