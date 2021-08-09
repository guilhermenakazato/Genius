import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GeniusCardConfig extends StatelessWidget {
  final int itemCount;
  final SwiperLayout layout;
  final Axis cardDirection;
  final Widget Function(BuildContext context, int index) builder;

  const GeniusCardConfig({
    Key key,
    @required this.itemCount,
    this.layout = SwiperLayout.DEFAULT,
    this.cardDirection = Axis.horizontal,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      scrollDirection: cardDirection,
      itemCount: itemCount,
      layout: layout,
      itemWidth: 300,
      itemHeight: 500,
      itemBuilder: builder,
    );
  }
}
