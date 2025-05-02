import 'package:screenshot/screenshot.dart';
import 'package:sunlight/src/clients/analytics_client.live.dart';
import 'package:sunlight/src/clients/analytics_client.dart' as analytics;
import 'package:sunlight/src/clients/board_client.dart' as board;
import 'package:sunlight/src/clients/logger_client.dart' as logger;
import 'package:sunlight/src/clients/logger_client.live.dart';
import 'package:sunlight/src/clients/snapshot_client.dart' as snapshot;
import 'package:sunlight/src/clients/snapshot_client.live.dart';

abstract class SunlightAnalytics {
  static ScreenshotController screenshotController = ScreenshotController();
  static var _isSetUp = false;

  static setup({
    required board.BoardClient boardClient,
    analytics.AnalyticsClient? analyticsClient,
    logger.LoggerClient? loggerClient,
    bool debug = false,
  }) {
    _isSetUp = true;
    board.boardClient = debug ? boardClient.debug.locked : boardClient.locked;
    analytics.analyticsClient = analyticsClient ?? snapshotAnalyticsClient;
    logger.loggerClient = loggerClient ?? noneLoggerClient;
    snapshot.snapshotClient = screenshotSnapshotClient(screenshotController);
  }

  static Future<void> log({required String name}) {
    if (!_isSetUp) {
      return Future.sync(() => null);
    }
    return analytics.analyticsClient.logEvent(name);
  }
}
