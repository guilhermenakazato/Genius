import "package:Genius/components/button.dart";
import 'package:flutter/cupertino.dart';

class ButtonRow extends StatelessWidget {
  final Widget simScreen, naoScreen;
  const ButtonRow({Key key, this.simScreen, this.naoScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Button(
          text: "Sim",
          widget: simScreen,
        ),
        Button(
          text: "Não",
          widget: naoScreen,
        ),
      ],
    );
  }
}
