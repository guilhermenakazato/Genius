import 'package:flutter/material.dart';

class NavigatorUtil {
  void navigate(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  void navigateAndReload(BuildContext context, Widget widget, Function function) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    })).then((value) => function());
  }

  void navigateAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }

  void navigateAndReplace(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      ModalRoute.withName('/'),
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
