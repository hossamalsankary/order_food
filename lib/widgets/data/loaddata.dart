import 'package:flutter/services.dart';

Future<String> loadAsset() async {
  var data = await rootBundle.loadString("assets/json/data.json");
  return data;
}
