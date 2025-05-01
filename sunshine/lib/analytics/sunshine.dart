import 'package:screenshot/screenshot.dart';
import 'package:sunshine/clients/analytics_client.live.dart';
import 'package:sunshine/clients/analytics_client.dart' as analytics;
import 'package:sunshine/clients/board_client.dart' as board;
import 'package:sunshine/clients/logger_client.dart' as logger;
import 'package:sunshine/clients/logger_client.live.dart';
import 'package:sunshine/clients/snapshot_client.dart' as snapshot;
import 'package:sunshine/clients/snapshot_client.live.dart';

abstract class SunshineAnalytics {
  static ScreenshotController screenshotController = ScreenshotController();

  static setup({
    required board.BoardClient boardClient,
    analytics.AnalyticsClient? analyticsClient,
    logger.LoggerClient? loggerClient,
    bool debug = false,
  }) {
    board.boardClient = debug ? boardClient.debug.locked : boardClient.locked;
    analytics.analyticsClient = analyticsClient ?? snapshotAnalyticsClient;
    logger.loggerClient = loggerClient ?? noneLoggerClient;
    snapshot.snapshotClient = screenshotSnapshotClient(screenshotController);
  }

  static Future<void> log({required String name}) {
    return analytics.analyticsClient.logEvent(name);
  }
}
