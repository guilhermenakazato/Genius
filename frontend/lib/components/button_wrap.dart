import "package:genius/components/button.dart";
import 'package:genius/utils/navigator_util.dart';
import 'package:flutter/cupertino.dart';

// TODO: documentar
class ButtonWrap extends StatelessWidget {
  final Widget simScreen, naoScreen;
  final String textSim, textNao;
  final Function addYesFunction, addNoFunction;
  final double width;

  const ButtonWrap({
    Key key,
    @required this.simScreen,
    @required this.naoScreen,
    this.textSim = "Sim",
    this.textNao = "Não",
    this.addYesFunction,
    this.addNoFunction,
    this.width = 95,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorUtil navigator = NavigatorUtil();

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Button(
            width: width,
            text: textSim,
            onClick: () {
              addYesFunction == null
                  ? debugPrint("Sem função")
                  : addYesFunction();
              navigator.navigate(context, simScreen);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Button(
            width: width,
            text: textNao,
            onClick: () {
              addNoFunction == null ? debugPrint("Sem função") : addNoFunction();
              navigator.navigate(context, naoScreen);
            },
          ),
        ),
      ],
    );
  }
}
