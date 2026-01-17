import 'dart:developer';
import 'package:flutter/material.dart';

class NavigationService{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName){
    if(navigatorKey.currentState!=null){
      log('pushing to $routeName');
      return navigatorKey.currentState!.pushNamed(routeName);
    }else{
      log('NavigationService navigatorKey is not attached to a Navigator.');
      throw StateError('NavigationService navigatorKey is not attached to a Navigator.');
    }
  }
  Future<dynamic> replaceNamed(String routeName){
    if(navigatorKey.currentState!=null){
      log('pushing(replacing) to $routeName');
      return navigatorKey.currentState!.pushReplacementNamed(routeName);
    }else{
      log('NavigationService navigatorKey is not attached to a Navigator.');
      throw StateError('NavigationService navigatorKey is not attached to a Navigator.');
    }
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    if (navigatorKey.currentState != null) {
      log('pushing to $routeName and removing until predicate is met');
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName,(route) => false);
    } else {
      log('NavigationService navigatorKey is not attached to a Navigator.');
      throw StateError('NavigationService navigatorKey is not attached to a Navigator.');
    }
  }

  Future<dynamic> push(Widget routeWidget){
    if(navigatorKey.currentState!=null){
      log('pushing to $routeWidget');
      return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => routeWidget));
    }else{
      log('NavigationService navigatorKey is not attached to a Navigator.');
      throw StateError('NavigationService navigatorKey is not attached to a Navigator.');
    }
  }

  void pop(){
    if(navigatorKey.currentState!=null){
      log('popping');
      return navigatorKey.currentState!.pop();
    }else{
      log('NavigationService navigatorKey is not attached to a Navigator.');
      throw StateError('NavigationService navigatorKey is not attached to a Navigator.');
    }
  }

}