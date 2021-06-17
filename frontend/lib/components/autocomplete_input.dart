import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

import 'package:genius/utils/application_colors.dart';

class AutoCompleteInput extends StatelessWidget {
  final String label;
  final GlobalKey<FlutterMentionsState> keyController;
  final List<Map<String, dynamic>> data;
  final String triggerChar;
  final String hint;
  final String defaultText;
  final SuggestionPosition position;
  final String type;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMentions(
      defaultText: defaultText,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      suggestionPosition: position,
      key: keyController,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.fromLTRB(22, 20, 22, 20),
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
        ),
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
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w700,
                ),
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
                style: TextStyle(
                  fontFamily: 'Gotham',
                  color: ApplicationColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                data['name'],
                style: TextStyle(
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
