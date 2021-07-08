import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/screens/main/profile.dart';
import 'package:genius/utils/application_typography.dart';
import 'package:genius/utils/navigator_util.dart';

import '../../http/webclients/search_webclient.dart';
import '../../models/project.dart';
import '../../http/webclients/tags_webclient.dart';
import '../../models/tag.dart';
import '../../models/user.dart';
import '../../utils/convert.dart';
import '../../utils/application_colors.dart';
import '../../models/token.dart';
import '../../http/webclients/user_webclient.dart';
import '../../components/search_bar.dart';
import '../../components/tag_bar.dart';
import 'project/project_info.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var initialTags = <String>['Mostrar projetos', 'Mostrar usuários'];
  final _selectedTags = <String>[];
  final _tokenObject = Token();
  String _searchText = '';
  var listOfTags;
  bool showUsers = false;
  bool showProjects = false;
  Future<String> _searchData;
  bool searched = false;
  final _navigator = NavigatorUtil();

  @override
  void initState() {
    super.initState();
    _searchData = _getSearchData();
  }

  Future<List<dynamic>> _getSearchScreenData() {
    var responses = Future.wait([
      _getDataByToken(),
      _getTagsData(),
    ]);

    return responses;
  }

  Future<User> _getDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _userJson = await _webClient.getUserData(_token);
    final _user = User.fromJson(jsonDecode(_userJson));

    return _user;
  }

  Future<List<Tag>> _getTagsData() async {
    final webClient = TagsWebClient();
    final tags = await webClient.getAllTags();
    final tagsList = Convert.convertToListOfTags(jsonDecode(tags));

    return tagsList;
  }

  Future<String> _getSearchData() async {
    final webClient = SearchWebClient();

    final searchResult = await webClient.search(
      _searchText,
      _selectedTags,
      showUsers,
      showProjects,
    );

    return searchResult;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSearchScreenData(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data[0];
          final tagsFromBackend = snapshot.data[1];

          listOfTags = _listOfTagsFromBackendWithInitialTags(tagsFromBackend);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 10),
                  child: SearchBar(
                    onChange: (String value) {
                      debugPrint(value);
                      setState(() {
                        _searchText = value.trim();
                        _searchData = _getSearchData();
                        searched = true;
                      });
                    },
                  ),
                ),
                TagBar(
                  tags: listOfTags,
                  onChangedState: (int position, bool value) {
                    _handleTagSelected(listOfTags, position, value);
                  },
                  tagsCount: listOfTags.length,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.725,
                  child: _determineSearchOutput(),
                ),
              ],
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _determineSearchOutput() {
    if (searched) {
      return _searchOutputWhenSelectedTagsOrInsertedTextOnField();
    } else {
      return _noSearchNorTagSelected(context);
    }
  }

  Widget _searchOutputWhenSelectedTagsOrInsertedTextOnField() {
    return FutureBuilder(
      future: _searchData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          var searchResult = json.decode(snapshot.data);
          var users = searchResult[0];
          var projects = searchResult[1];

          if (users.isEmpty && projects.isEmpty) {
            return _emptyResult();
          } else {
            users = Convert.convertToListOfUsers(users);
            projects = Convert.convertToListOfProjects(projects);

            return _foundResults(users, projects);
          }
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _emptyResult() {
    return Text('nao conseguimos achar nada...');
  }

  Widget _foundResults(List<User> users, List<Project> projects) {
    var newList = <dynamic>{...users, ...projects}.toList();

    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Divider(
          color: Colors.white70,
        ),
      ),
      itemCount: newList.length,
      itemBuilder: (BuildContext context, int index) {
        if (newList[index] is User) {
          return _userResult(newList[index]);
        } else {
          return _projectResult(newList[index]);
        }
      },
    );
  }

  Widget _userResult(User user) {
    return InkWell(
      onTap: () {
        _navigator.navigate(
          context,
          Profile(
            type: 'search',
            id: user.id,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                user.username,
                style: ApplicationTypography.mentionStyle,
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                user.name,
                style: ApplicationTypography.mentionFullNameStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectResult(Project project) {
    return InkWell(
      onTap: () {
        _navigator.navigate(
          context,
          ProjectInfo(
            project: project,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                project.name,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noSearchNorTagSelected(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Column(
            children: [
              Container(
                width: 310.0,
                height: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/search.png'),
                  ),
                ),
              ),
              Text(
                'Pesquise por projetos e\nusuários ou clique nas tags!',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleTagSelected(List<String> tags, int position, bool selected) {
    if (tags[position] == 'Mostrar projetos') {
      showProjects = selected;
    } else if (tags[position] == 'Mostrar usuários') {
      showUsers = selected;
    } else if (selected) {
      _selectedTags.add(tags[position]);
    } else {
      _selectedTags.remove(tags[position]);
    }

    setState(() {
      _searchData = _getSearchData();
      searched = true;
    });
  }

  List<String> _listOfTagsFromBackendWithInitialTags(List<Tag> tags) {
    var listOfTags = <String>[];

    for (var i = 0; i < initialTags.length; i++) {
      listOfTags.add(initialTags[i]);
    }

    for (var i = 0; i < tags.length; i++) {
      listOfTags.add(tags[i].name);
    }

    return listOfTags;
  }
}
