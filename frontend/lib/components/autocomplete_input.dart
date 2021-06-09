import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

class AutoCompleteInput extends StatelessWidget {
  final String label;
  final GlobalKey<FlutterMentionsState> keyController;
  final List<Map<String, dynamic>> data;
  final String triggerChar;

  const AutoCompleteInput({
    Key key,
    @required this.label,
    this.keyController,
    @required this.data,
    @required this.triggerChar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMentions(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      suggestionPosition: SuggestionPosition.Bottom,
      key: keyController,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
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
        ),
      ],
    );
  }
}
