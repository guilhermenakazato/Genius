import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/application_colors.dart';

class SkeletonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: ApplicationColors.baseLoadingColor,
            highlightColor: ApplicationColors.highlightLoadingColor,
            child: Container(
              width: 300,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ApplicationColors.shadowLoadingColor,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: ApplicationColors.baseLoadingColor,
            highlightColor: ApplicationColors.highlightLoadingColor,
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 48,
                color: ApplicationColors.shadowLoadingColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
