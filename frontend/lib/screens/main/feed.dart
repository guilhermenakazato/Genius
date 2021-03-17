import 'package:flutter/material.dart';
import 'package:genius/screens/main/project/project_info.dart';
import 'package:genius/utils/navigator_util.dart';
import 'package:tcard/tcard.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with TickerProviderStateMixin {
  TCardController _controller = TCardController();
  var projetos = [for (int i = 1; i < 20; i++) i];
  int _index = 0;
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: TCard(
          controller: _controller,
          onForward: (index, info) {
            _index = index;
            debugPrint(info.direction.toString());
            setState(() {});
          },
          onBack: (index) {
            _index = index;
            setState(() {});
          },
          size: Size(350, 500),
          cards: [
            for (var projeto in projetos)
              Card(
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
                      // card tá em cima
                      if (_index + 1 == projeto) {
                        navigator.navigate(
                            context,
                            ProjectInfo(
                              number: projeto,
                            ));
                      }
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Projeto $projeto",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 30, 0),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in [...]",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
