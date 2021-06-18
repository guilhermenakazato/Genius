import 'package:flutter/cupertino.dart';

import 'button.dart';
import '../utils/navigator_util.dart';

class ButtonWrap extends StatelessWidget {
  final Widget yesScreen, noScreen;
  final String textYes, textNo;
  final Function addYesFunction, addNoFunction;
  final double width;
  final Widget additionalWidget;

  const ButtonWrap({
    Key key,
    @required this.yesScreen,
    @required this.noScreen,
    this.textYes = 'Sim',
    this.textNo = 'Não',
    this.addYesFunction,
    this.addNoFunction,
    this.width = 95,
    this.additionalWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = NavigatorUtil();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children: <Widget>[
        Button(
          width: width,
          text: textYes,
          onClick: () {
            if (addYesFunction != null) {
              addYesFunction();
            }
            navigator.navigate(context, yesScreen);
          },
        ),
        Button(
          width: width,
          text: textNo,
          onClick: () {
            if (addNoFunction != null) {
              addNoFunction();
            }
            navigator.navigate(context, noScreen);
          },
        ),
        _shouldShowAdditionalWidget(),
      ],
    );
  }

  Widget _shouldShowAdditionalWidget() {
    if (additionalWidget != null) {
      return additionalWidget;
    } else {
      return Container();
    }
  }
}
