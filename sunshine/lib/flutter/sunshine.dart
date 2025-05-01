import 'package:flutter/widgets.dart';

import 'package:screenshot/screenshot.dart';
import 'package:sunshine/analytics/sunshine.dart';

class Sunshine extends StatelessWidget {
  final Widget child;

  const Sunshine({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: SunshineAnalytics.screenshotController,
      child: child,
    );
  }
}
