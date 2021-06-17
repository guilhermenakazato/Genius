import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../http/webclients/tags_webclient.dart';
import '../../../utils/convert.dart';
import '../../../utils/genius_toast.dart';
import '../../../components/autocomplete_input.dart';
import '../../../models/tag.dart';
import '../../../http/webclients/signup_webclient.dart';
import '../../../http/exceptions/http_exception.dart';
import '../../../models/token.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/user.dart';
import '../../../utils/application_colors.dart';
import '../../../components/picker.dart';
import '../../../components/gradient_button.dart';
import '../../../utils/application_typography.dart';
import '../../../components/dropdown_button.dart';
import '../../../components/input_with_animation.dart';

class EditProfile extends StatefulWidget {
  final int id;

  const EditProfile({Key key, @required this.id}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _tagsInitText = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _residencyController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final _typeOptions = <String>['Estudante', 'Professor'];
  final _formationOptions = <String>[
    'Primeiro grau completo',
    'Primeiro grau incompleto',
    'Segundo grau completo',
    'Segundo grau incompleto',
    'Ensino profissional de nível técnico completo',
    'Ensino profissional de nível técnico incompleto',
    'Graduação completa',
    'Graduação incompleta',
    'Especialização completa',
    'Especialização incompleta',
    'Mestrado completo',
    'Mestrado incompleto',
    'Doutorado completo',
    'Doutorado incompleto'
  ];

  String _typeController;
  String _formationController;
  int _ageController;
  final _tokenObject = Token();
  final _key = GlobalKey<FormState>();
  final _tagsKey = GlobalKey<FlutterMentionsState>();

  @override
  void initState() {
    _getProfileData();
    super.initState();
  }

  Future<List<dynamic>> _getProfileData() {
    var responses = Future.wait([
      _getUserData(),
      _getTagsData(),
    ]);

    return responses;
  }

  Future<User> _getUserData() async {
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

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: FutureBuilder(
        future: _getProfileData(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data[0];
            final tags = snapshot.data[1];

            _fillInputs(user);
            final tagsMap = _defineAutocomplete(tags);

            return Theme(
              data: Theme.of(context).copyWith(
                splashColor: ApplicationColors.splashColor,
              ),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Align(
                    child: Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          _photoWidget(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
                            child: InputWithAnimation(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, escreva algo.';
                                }
                                return null;
                              },
                              controller: _nameController,
                              type: TextInputType.name,
                              label: 'Nome completo',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: InputWithAnimation(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, escreva algo.';
                                } else if (value == '@') {
                                  return 'Escreva um nome de usuário.';
                                } else if (value.contains(' ')) {
                                  return 'Remova os espaços em branco.';
                                }
                                return null;
                              },
                              controller: _usernameController,
                              type: TextInputType.name,
                              label: 'Nome de usuário',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: Container(
                              height: 95,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Idade:',
                                      style:
                                          ApplicationTypography.specialAgeInput,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Picker(
                                      onChanged: (int value) {
                                        _ageController = value + 10;
                                      },
                                      initialValue: int.parse(user.age) - 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: InputWithAnimation(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, escreva algo.';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Insira um e-mail válido.';
                                }
                                return null;
                              },
                              controller: _emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: InputWithAnimation(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, escreva algo.';
                                }
                                return null;
                              },
                              controller: _residencyController,
                              type: TextInputType.streetAddress,
                              label: 'Moradia',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: InputWithAnimation(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, escreva algo.';
                                }
                                return null;
                              },
                              controller: _institutionController,
                              type: TextInputType.streetAddress,
                              label: 'Instituição',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: DropDownButton(
                              hint: user.type,
                              items: _typeOptions,
                              width: 325,
                              onValueChanged: (String value) {
                                _typeController = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: DropDownButton(
                              hint: user.formation,
                              items: _formationOptions,
                              width: 325,
                              onValueChanged: (String value) {
                                _formationController = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: AutoCompleteInput(
                              position: SuggestionPosition.Top,
                              defaultText: _tagsInitText,
                              keyController: _tagsKey,
                              hint: '#tag',
                              label: 'Favoritos',
                              data: tagsMap,
                              triggerChar: '#',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: InputWithAnimation(
                              controller: _bioController,
                              type: TextInputType.multiline,
                              label: 'Bio',
                              allowMultilines: true,
                              maxChar: 180,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GradientButton(
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  _handleFormSubmit(user, context);
                                }
                              },
                              text: 'Salvar',
                              width: 270,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SpinKitFadingCube(color: ApplicationColors.primary);
          }
        },
      ),
    );
  }

  List<Map<String, dynamic>> _defineAutocomplete(List<Tag> tags) {
    var listOfTagsWithMap = <Map<String, dynamic>>[];

    tags.forEach((tag) {
      var map = <String, dynamic>{};

      map['display'] = tag.name.replaceAll('#', '');
      map['id'] = tag.id.toString();

      listOfTagsWithMap.add(map);
    });

    return listOfTagsWithMap;
  }

  void _fillInputs(User user) {
    _nameController.text = user.name;
    _usernameController.text = user.username;
    _emailController.text = user.email;
    _residencyController.text = user.local;
    _institutionController.text = user.institution;
    _bioController.text = user.bio;
    _typeController = user.type;
    _ageController = int.parse(user.age);
    _formationController = user.formation;
    _tagsInitText = _transformListOfTagsIntoStringOfTags(user.tags);
  }

  String _transformListOfTagsIntoStringOfTags(List<Tag> tags) {
    var _stringOfTags = '';

    tags.forEach((tag) {
      _stringOfTags += tag.name;
      _stringOfTags += ' ';
    });

    return _stringOfTags;
  }

  void _handleFormSubmit(User user, BuildContext context) {
    var tagsText = _tagsKey.currentState.controller.text;

    var name = _nameController.text;
    var username = _usernameController.text;
    var email = _emailController.text;
    var type = _typeController;
    var age = _ageController.toString();
    var residency = _residencyController.text;
    var institution = _institutionController.text;
    var formation = _formationController;
    var bio = _bioController.text.trim();

    var tags = tagsText.trim().split(' ');
    tags = tags.toSet().toList();

    if (!username.startsWith('@')) {
      username = '@' + username;
    }

    final tagVerificationPassed = _verifyTags(tags);

    if (tagVerificationPassed) {
      var person = User(
        name: name,
        username: username,
        email: email,
        type: type,
        age: age,
        local: residency,
        institution: institution,
        formation: formation,
        bio: bio,
        password: user.password,
        tags: tags,
      );

      updateUserData(person, user, user.id, context);
    }
  }

  bool _verifyTags(List<String> tags) {
    var verification = true;

    if (tags.length == 1 && (tags[0] == ' ' || tags[0] == '')) {
      tags.clear();
    }

    if (tags.isNotEmpty) {
      tags.forEach((tag) {
        if (!tag.startsWith('#')) {
          GeniusToast.showToast('A tag $tag está sem #!');
          verification = false;
        }
      });
    }

    return verification;
  }

  void updateUserData(User newUserData, User oldUserData, int userId,
      BuildContext context) async {
    final _webClientToVerifyData = SignUpWebClient();
    final progress = ProgressHUD.of(context);

    progress.show();

    var usernameAlreadyExists = false;
    var emailAlreadyExists = false;

    if (oldUserData.username != newUserData.username) {
      usernameAlreadyExists = await _webClientToVerifyData
          .verifyIfUsernameAlreadyExists(newUserData.username);
    } else if (oldUserData.email != newUserData.email) {
      emailAlreadyExists = await _webClientToVerifyData
          .verifyIfEmailAlreadyExists(newUserData.email);
    }

    if (usernameAlreadyExists) {
      progress.dismiss();
      GeniusToast.showToast('Ops! Alguém já está registrado com esse nome de usuário.');
    } else if (emailAlreadyExists) {
      progress.dismiss();
      GeniusToast.showToast('Ops! Alguém já está registrado com esse e-mail.');
    } else {
      updateUser(newUserData, userId, context);

      GeniusToast.showToast('Perfil atualizado com sucesso!');
      progress.dismiss();
    }
  }

  void updateUser(User newUserData, int userId, BuildContext context) async {
    final _webClient = UserWebClient();
    final progress = ProgressHUD.of(context);

    await _webClient.updateUser(newUserData, userId).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro desconhecido.');
    });
  }

  Widget _photoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/sem-foto.png'),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ApplicationColors.addPhotoColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
