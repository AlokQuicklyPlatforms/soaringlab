import 'package:flutter/material.dart';
import '../features/home/view/home_page.dart';
// import '../features/other_feature/other_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String otherFeature = '/other';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomePage(),
      // otherFeature: (context) => OtherPage(),
    };
  }
}
