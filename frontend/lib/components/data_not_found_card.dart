import 'package:flutter/material.dart';
import 'package:genius/utils/application_typography.dart';

class DataNotFoundCard extends StatelessWidget {
  final String text;
  final Color color;

  const DataNotFoundCard(
      {Key key, @required this.text, this.color = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: ApplicationTypography.notFoundText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
