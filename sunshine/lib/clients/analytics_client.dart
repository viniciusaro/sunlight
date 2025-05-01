var analyticsClient = unimplementedAnalyticsClient;

final class AnalyticsClient {
  final Future<void> Function(String name) logEvent;
  AnalyticsClient({required this.logEvent});
}

final unimplementedAnalyticsClient = AnalyticsClient(
  logEvent: (_) => throw UnimplementedError(_unimplementedError),
);

const _unimplementedError =
    "[Sunshine] Unimplemented analytics client: Did you run SunshineAnalytics.setup?";
