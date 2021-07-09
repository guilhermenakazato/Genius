import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/utils/genius_toast.dart';
import '../../../components/gradient_button.dart';
import '../../../models/user.dart';
import '../../../utils/navigator_util.dart';

import '../../../utils/application_colors.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/token.dart';
import '../../../utils/application_typography.dart';
import '../profile.dart';

class Following extends StatefulWidget {
  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  Future<String> _userData;
  final _tokenObject = Token();
  final _navigator = NavigatorUtil();

  @override
  void initState() {
    super.initState();
    _userData = _getDataByToken();
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
        child: Builder(
          builder: (context) {
            return FutureBuilder(
              future: _userData,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  final user = User.fromJson(jsonDecode(snapshot.data));

                  if (user.following.isEmpty) {
                    return Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'vc ainda nao tá seguindo ngm',
                            style: ApplicationTypography.testText,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 8.0),
                      itemCount: user.following.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            _navigator.navigateAndReload(
                              context,
                              Profile(
                                type: 'follows',
                                id: user.following[index].id,
                                follower: user,
                              ),
                              () {
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GradientButton(
                                    onPressed: () {
                                      unfollow(
                                        user.following[index],
                                        user,
                                        context,
                                      );
                                    },
                                    text: 'Deixar de seguir',
                                    width: 100,
                                    height: 50,
                                  ),
                                ),
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
          },
        ),
      ),
    );
  }

  void unfollow(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    var unfollowed = true;
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.unfollow(user.id, follower.id, false).catchError((error) {
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
}
