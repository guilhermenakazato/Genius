import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:genius/utils/application_colors.dart';
import 'package:genius/utils/application_typography.dart';

class SubmitFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(30),
        dashPattern: [8, 4],
        color: ApplicationColors.primary,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 46,
                color: ApplicationColors.primary,
              ),
              Text(
                'Adicionar\nanexo',
                textAlign: TextAlign.center,
                style: ApplicationTypography.submitArchiveText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
