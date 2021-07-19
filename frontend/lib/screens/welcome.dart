import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/ask_user.dart';
import '../utils/application_typography.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AskUser();
        }));
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Align(child: _determineWhichWidgetShouldBeDisplayed()),
      ),
    );
  }

  Widget _determineWhichWidgetShouldBeDisplayed() {
    if (SizerUtil.deviceType == DeviceType.mobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _welcomeText(),
          _welcomeImage(),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _welcomeText(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2.h),
            child: _welcomeImage(),
          ),
        ],
      );
    }
  }

  Widget _welcomeText() {
    return Text(
      'Bem\nVindo!',
      style: ApplicationTypography.welcomeTitle,
      textAlign: TextAlign.center,
    );
  }

  Widget _welcomeImage() {
    return Container(
      width: 70.w,
      height: 45.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/mulher-cfolha.png'),
        ),
      ),
    );
  }
}
