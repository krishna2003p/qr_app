import 'package:flutter/widgets.dart';

class ScreenSize {
  final BuildContext context;
  ScreenSize(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  double heightFraction(double fraction) => height * fraction;
  double widthFraction(double fraction) => width * fraction;
}

