import "package:Genius/components/button.dart";
import 'package:Genius/utils/navigator_util.dart';
import 'package:flutter/cupertino.dart';

class ButtonRow extends StatelessWidget {
  final Widget simScreen, naoScreen;
  const ButtonRow({Key key, this.simScreen, this.naoScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorUtil navigator = NavigatorUtil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Button(
          text: "Sim",
          onClick: () {
            navigator.navigate(context, simScreen);
          },
        ),
        Button(
          text: "Não",
          onClick: () {
            navigator.navigate(context, naoScreen);
          },
        ),
      ],
    );
  }
}
