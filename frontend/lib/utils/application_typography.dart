import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'application_colors.dart';

class ApplicationTypography {
  static final appBar = TextStyle(
    color: Colors.white,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w300,
    fontSize: 20,
  );

  static final welcomeTitle = TextStyle(
    fontFamily: 'Gotham',
    fontSize: 60.sp,
    letterSpacing: 1.5,
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
    height: 1.0,
  );

  static final like = TextStyle(
    fontFamily: 'Gotham',
    height: 1.3,
  );

  static final askUserText = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 26.sp,
    fontWeight: FontWeight.bold,
  );

  static final loginTitle = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 60,
    fontWeight: FontWeight.w900,
  );

  static final presentationText = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 23.sp,
    height: 2,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w900,
  );

  static final introScienceText = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w900,
    fontFamily: 'Gotham',
    height: 1.2,
  );

  static final questionScienceText = TextStyle(
    color: ApplicationColors.primary,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w900,
    fontSize: 24.sp,
  );

  static final primarySignUpText = TextStyle(
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
    fontSize: 18.sp,
  );

  static final secondarySignUpText = TextStyle(
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
    fontSize: 19.sp,
  );

  static final signUpIntro = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w900,
    height: 1.2,
    fontFamily: 'Gotham',
  );

  static final cardTitle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static final cardText = TextStyle(
    color: Colors.white,
    fontSize: 15,
    height: 1.3,
  );

  static final aboutTitle = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static final aboutText = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 20,
    height: 1.5,
    fontWeight: FontWeight.w900,
  );

  static final teamMembers = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 15,
    fontWeight: FontWeight.w900,
  );

  static final teamMembersTitle = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static final switchTile = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  static final borderlessButton = (Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      );

  static final specialAgeInput = TextStyle(
    fontSize: 18,
    color: ApplicationColors.primary,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w700,
  );

  static final borderlessInput = TextStyle(
    fontSize: 18.sp,
    color: Colors.white,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w700,
  );

  static final borderlessInputHint = TextStyle(
    fontSize: 18.sp,
    color: ApplicationColors.inputHintColor,
    fontWeight: FontWeight.w900,
  );

  static final button = TextStyle(
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
    fontSize: 18,
  );

  static final gradientButton = TextStyle(
    color: ApplicationColors.gradientButtonTextColor,
    fontWeight: FontWeight.w900,
    fontSize: 16,
  );

  static final input = TextStyle(
    color: Colors.white,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );
  static final inputHint = TextStyle(
    color: ApplicationColors.inputHintColor,
    fontWeight: FontWeight.w900,
  );

  static final configTitle = TextStyle(
    color: ApplicationColors.configTitle,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static final searchResultTitle = TextStyle(
    color: ApplicationColors.configTitle,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static final searchField = TextStyle(
    color: ApplicationColors.searchFieldTextColor,
  );

  static final searchFieldHint = TextStyle(
    color: ApplicationColors.searchFieldHintColor,
  );

  static final listTileText = (Color color) => TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      );

  static final profileName = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: ApplicationColors.profileNameColor,
    overflow: TextOverflow.ellipsis,
  );

  static final profileCity = TextStyle(
    color: ApplicationColors.profileCityColor,
    wordSpacing: 2,
    letterSpacing: 4,
  );

  static final numberFollowProfile = TextStyle(
    color: ApplicationColors.numberFollowProfileColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static final numberFollowCaptionProfile = TextStyle(
    color: ApplicationColors.numberFollowCaptionProfileColor,
  );

  static final profileTags = TextStyle(
    color: ApplicationColors.profileTagsTextColor,
    fontWeight: FontWeight.w700,
    fontFamily: 'Gotham',
  );

  static final profileInfoTitle = TextStyle(
    fontWeight: FontWeight.w900,
    fontFamily: 'Gotham',
    fontSize: 33,
    color: Colors.white,
  );

  static final profileInfoPageTitle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    fontFamily: 'Gotham',
    color: Colors.white,
  );

  static final dropdownButton = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Gotham',
    color: ApplicationColors.primary,
  );

  static final tabBarText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );

  static final tabUsername = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );

  static final testText = TextStyle(
    color: ApplicationColors.primary,
  );

  static final submitArchiveText = TextStyle(
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w800,
  );

  static final aboutMeText = TextStyle(
    fontWeight: FontWeight.w300,
    fontFamily: 'Gotham',
    fontSize: 16,
  );

  static final aboutTeam = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'Gotham',
    fontSize: 14,
    height: 1,
  );

  static final deleteRequestsCardText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontFamily: 'Gotham',
    fontSize: 18,
  );

  static final notFoundText = TextStyle(
    color: ApplicationColors.notFoundColor,
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w300,
    height: 1.3,
  );

  static final inputText = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final inputLabelText = TextStyle(
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
  );

  static final projectNameText = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  static final projectAbstractText = TextStyle(
    color: Colors.white,
    fontSize: 15,
    height: 1.3,
  );

  static final linkStyle = TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.blue,
  );

  static final normalButWithLinkStyle = TextStyle(
    color: Colors.white,
  );

  static final mentionStyle = TextStyle(
    fontFamily: 'Gotham',
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
  );

  static final mentionFullNameStyle = TextStyle(
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w500,
  );

  static final tagStyle = TextStyle(
    fontFamily: 'Gotham',
    fontWeight: FontWeight.w700,
  );
}
