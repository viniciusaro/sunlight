import 'package:flutter/widgets.dart';

import 'package:screenshot/screenshot.dart';
import 'package:sunlight/src/analytics/sunlight.dart';

class Sunlight extends StatelessWidget {
  final Widget child;

  const Sunlight({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: SunlightAnalytics.screenshotController,
      child: child,
    );
  }
}
