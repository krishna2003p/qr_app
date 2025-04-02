import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();
  double _lastOffset = 0;
  final ScrollController scrollController = ScrollController();
  bool _isBottomNavVisible = true;
  HomeProvider() {
    scrollController.addListener(_scrollListener);
  }
  int get currentIndex => _currentIndex;
  bool get isBottomNavVisible => _isBottomNavVisible;

  void _scrollListener() {
    if (scrollController.offset > _lastOffset) {
      hideBottomNav();
    } else if (scrollController.offset < _lastOffset) {
      showBottomNav();
    }
    _lastOffset = scrollController.offset;
  }

  void animateToPage(int page) {
    _currentIndex = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
    );
    notifyListeners();
  }

  void hideBottomNav() {
    if (_isBottomNavVisible) {
      _isBottomNavVisible = false;
      notifyListeners();
    }
  }

  void showBottomNav() {
    if (!_isBottomNavVisible) {
      _isBottomNavVisible = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
