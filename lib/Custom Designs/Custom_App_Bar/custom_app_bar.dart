import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';
import '../../util/Screen Size/screen_size.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;
  @override
  final Size preferredSize;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.child,
    required this.onPressed,
    required this.onTitleTapped,
  }) : preferredSize = const Size.fromHeight(120);
  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: 'topBarBtn',
                child: Card(
                  elevation: 10,
                  shape: kBackButtonShape,
                  child: MaterialButton(
                    height: screenSize.heightFraction(0.1),
                    minWidth: screenSize.widthFraction(0.15),
                    elevation: 10,
                    shape: kBackButtonShape,
                    onPressed: () => onPressed(),
                    child: child,
                  ),
                ),
              ),
              Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: Card(
                  elevation: 10,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(screenSize.widthFraction(0.1)),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => onTitleTapped(),
                    child: SizedBox(
                      width: screenSize.widthFraction(0.7),
                      height: screenSize.heightFraction(0.1),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: screenSize.widthFraction(0.08)),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.widthFraction(0.06),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

ShapeBorder kBackButtonShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = const Icon(
  Icons.person_2_rounded,
  size: 45,
  color: AppColors.primary,
);
