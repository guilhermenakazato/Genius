import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

// TODO: documentar
class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with TickerProviderStateMixin {
  TCardController _controller = TCardController();
  var projetos = [for (int i = 1; i < 20; i++) i];
  int _index = 0;

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
                      if (_index + 1 == projeto) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Vai abrir o projeto $projeto"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Não vai abrir o projeto $projeto"),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Projeto $projeto",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
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
