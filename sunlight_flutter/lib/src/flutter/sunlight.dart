import 'package:flutter/widgets.dart';

import 'package:screenshot/screenshot.dart';

import '../../sunlight_flutter.dart';

class Sunlight extends StatelessWidget {
  final Widget child;

  const Sunlight({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: SunlightAnalyticsFlutter.screenshotController,
      child: child,
    );
  }
}
