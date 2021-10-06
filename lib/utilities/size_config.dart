import 'package:flutter/widgets.dart';

class SizeConfig {

  MediaQueryData _mediaQueryData;
  static double deviceWidth;
  static double deviceHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    deviceWidth = _mediaQueryData.size.width / 100;
    deviceHeight = _mediaQueryData.size.height / 100;
  }
}