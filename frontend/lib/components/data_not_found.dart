import 'package:flutter/material.dart';
import '../utils/application_colors.dart';

class DataNotFound extends StatelessWidget {
  final String text;

  const DataNotFound({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 450,
      child: Card(
        elevation: 0,
        color: ApplicationColors.secondCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Center(
              child: Text(
                text, 
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
