import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(AppSizes.blockSizeHorizontal * 3, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - AppSizes.blockSizeHorizontal * 3, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


double animatedPositionedLEftValue(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return AppSizes.blockSizeHorizontal * 5.5;
    case 1:
      return AppSizes.blockSizeHorizontal * 22.5;
    case 2:
      return AppSizes.blockSizeHorizontal * 39.5;
    case 3:
      return AppSizes.blockSizeHorizontal * 56.5;
    case 4:
      return AppSizes.blockSizeHorizontal * 73.5;
    default:
      return 0;
  }
}


final List<Color> gradient = [
  Colors.yellow.withValues(alpha: 0.8),
  Colors.yellow.withValues(alpha: 0.5),
  Colors.transparent
];

class AppSizes {
  static final AppSizes _instance = AppSizes._internal();
  factory AppSizes() => _instance;
  AppSizes._internal();

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
