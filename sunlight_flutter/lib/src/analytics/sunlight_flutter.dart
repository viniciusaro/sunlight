import 'package:screenshot/screenshot.dart';
import 'package:sunlight/sunlight.dart';

import '../clients/snapshot_client.live.dart';

abstract class SunlightAnalyticsFlutter {
  static ScreenshotController screenshotController = ScreenshotController();

  static setup({
    required BoardClient boardClient,
    LoggerClient? loggerClient,
    bool debug = false,
  }) {
    return SunlightAnalytics.setup(
      boardClient: boardClient,
      snapshotClient: screenshotSnapshotClient(screenshotController),
      loggerClient: loggerClient,
      debug: debug,
    );
  }

  static Future<void> log({required String name}) {
    return SunlightAnalytics.log(name: name);
  }
}
