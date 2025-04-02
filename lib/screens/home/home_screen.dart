import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../Custom Designs/Custom_App_Bar/bottom_nav_btn.dart';
import '../../Custom Designs/Custom_App_Bar/custom_app_bar.dart';
import '../../Custom Designs/Custom_App_Bar/custom_clipper.dart';
import 'home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: "QR APP",
        child: kBackBtn,
        onPressed: () {},
        onTitleTapped: () {},
      ),
      body: Stack(
        children: [
          PageView(
            controller: homeProvider.pageController,
            onPageChanged: (index) => homeProvider.animateToPage(index),
            children: List.generate(5, (pageIndex) {
              return SingleChildScrollView(
                controller: homeProvider.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    50,
                        (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Page $pageIndex - Item $index",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                0,
                homeProvider.isBottomNavVisible ? 0 : 100,
                0,
              ),
              child: bottomNav(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNav(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.blockSizeHorizontal * 4.5,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
          elevation: 6,
          child: Container(
            height: AppSizes.blockSizeHorizontal * 18,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavBTN(
                        onPressed: homeProvider.animateToPage,
                        icon: IconlyLight.home,
                        currentIndex: homeProvider.currentIndex,
                        index: 0,
                      ),
                      BottomNavBTN(
                        onPressed: homeProvider.animateToPage,
                        icon: IconlyLight.search,
                        currentIndex: homeProvider.currentIndex,
                        index: 1,
                      ),
                      BottomNavBTN(
                        onPressed: homeProvider.animateToPage,
                        icon: IconlyLight.category,
                        currentIndex: homeProvider.currentIndex,
                        index: 2,
                      ),
                      BottomNavBTN(
                        onPressed: homeProvider.animateToPage,
                        icon: IconlyLight.setting,
                        currentIndex: homeProvider.currentIndex,
                        index: 3,
                      ),
                      BottomNavBTN(
                        onPressed: homeProvider.animateToPage,
                        icon: IconlyLight.profile,
                        currentIndex: homeProvider.currentIndex,
                        index: 4,
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  top: 0,
                  left: animatedPositionedLEftValue(homeProvider.currentIndex),
                  child: Column(
                    children: [
                      Container(
                        height: AppSizes.blockSizeHorizontal * 1.0,
                        width: AppSizes.blockSizeHorizontal * 12,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      ClipPath(
                        clipper: MyCustomClipper(),
                        child: Container(
                          height: AppSizes.blockSizeHorizontal * 15,
                          width: AppSizes.blockSizeHorizontal * 12,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: gradient,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
