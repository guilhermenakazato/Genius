import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GeniusCardConfig extends StatelessWidget {
  final int itemCount;
  final SwiperLayout layout;
  final Axis cardDirection;
  final Widget Function(BuildContext context, int index) builder;
  final double width, height;

  const GeniusCardConfig({
    Key key,
    @required this.itemCount,
    this.layout = SwiperLayout.DEFAULT,
    this.cardDirection = Axis.horizontal,
    @required this.builder, this.width = 300, this.height = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      scrollDirection: cardDirection,
      itemCount: itemCount,
      layout: layout,
      itemWidth: width,
      itemHeight: height,
      itemBuilder: builder,
    );
  }
}
