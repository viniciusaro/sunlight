import 'package:sunlight/src/clients/analytics_client.live.dart';
import 'package:sunlight/src/clients/analytics_client.dart' as analytics;
import 'package:sunlight/src/clients/board_client.dart' as board;
import 'package:sunlight/src/clients/logger_client.dart' as logger;
import 'package:sunlight/src/clients/logger_client.live.dart';
import 'package:sunlight/src/clients/snapshot_client.dart' as snapshot;

abstract class SunlightAnalytics {
  static var _isSetUp = false;

  static setup({
    required board.BoardClient boardClient,
    required snapshot.SnapshotClient snapshotClient,
    analytics.AnalyticsClient? analyticsClient,
    logger.LoggerClient? loggerClient,
    bool debug = false,
  }) {
    _isSetUp = true;
    board.boardClient = debug ? boardClient.debug.locked : boardClient.locked;
    analytics.analyticsClient = analyticsClient ?? snapshotAnalyticsClient;
    logger.loggerClient = loggerClient ?? noneLoggerClient;
    snapshot.snapshotClient = snapshotClient;
  }

  static Future<void> log({required String name}) {
    if (!_isSetUp) {
      return Future.sync(() => null);
    }
    return analytics.analyticsClient.logEvent(name);
  }
}
