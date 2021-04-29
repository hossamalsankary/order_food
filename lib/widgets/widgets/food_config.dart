import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Collecting extends InheritedWidget {
  List<Map> card = [];
  Map maindata = {};
  Map restaurant = {};
  Map food = {};
  Collecting({child}) : super(child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Collecting? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}
