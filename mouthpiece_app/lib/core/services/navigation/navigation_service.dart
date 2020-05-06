import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = new GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  /* bool pop() {
    return _navigationKey.currentState.pop();
  } */

  Future<dynamic> navigateTo(String routeName) {
    return _navigationKey.currentState.pushNamed(routeName);
  }
}