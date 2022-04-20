import 'package:flutter/foundation.dart';

class Log {
  static String tag = 'divination';

  static info(String text) {
    if(kDebugMode) {
      print('[$tag][info] $text');
    }
  }

  static warn(String text) {
    if(kDebugMode) {
      print('[$tag][warn] $text');
    }
  }
}