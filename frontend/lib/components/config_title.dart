import 'package:flutter/material.dart';

import '../utils/application_typography.dart';

class ConfigTitle extends StatelessWidget {
  final String text;

  const ConfigTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'CONFIGURAÇÕES DA CONTA',
          style: ApplicationTypography.configTitle,
        ),
      ),
    );
  }
}