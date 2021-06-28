import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

import '../utils/application_typography.dart';

class AutoCompleteInput extends StatelessWidget {
  final String label;
  final GlobalKey<FlutterMentionsState> keyController;
  final List<Map<String, dynamic>> data;
  final String triggerChar;
  final String hint;
  final String defaultText;
  final SuggestionPosition position;
  final String type;
  final bool allowMultilines;

  const AutoCompleteInput({
    Key key,
    @required this.label,
    this.keyController,
    @required this.data,
    @required this.triggerChar,
    @required this.hint,
    this.defaultText,
    this.position = SuggestionPosition.Bottom,
    this.type,
    this.allowMultilines = false,
  }) : super(key: key);

  int _verifyIfMultiLinesIsAllowed() {
    if (allowMultilines) {
      return null;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMentions(
      defaultText: defaultText,
      maxLines: _verifyIfMultiLinesIsAllowed(),
      keyboardType: TextInputType.multiline,
      suggestionPosition: position,
      key: keyController,
      cursorColor: Theme.of(context).primaryColor,
      style: ApplicationTypography.inputText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.fromLTRB(22, 20, 22, 20),
        labelStyle: ApplicationTypography.inputLabelText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      mentions: [
        Mention(
          trigger: triggerChar,
          data: data,
          suggestionBuilder: (data) {
            return Container(
              color: Colors.black,
              padding: EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(12),
                child: _determineWhichAutocompleteShouldDisplay(data),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _determineWhichAutocompleteShouldDisplay(Map<String, dynamic> data) {
    if (type == 'tag') {
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                '#' + data['display'],
                style: ApplicationTypography.tagStyle
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                '@' + data['display'],
                style: ApplicationTypography.mentionStyle,
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                data['name'],
                style: ApplicationTypography.mentionFullNameStyle,
              ),
            ),
          ],
        ),
      );
    }
  }
}
