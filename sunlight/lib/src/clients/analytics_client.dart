var analyticsClient = unimplementedAnalyticsClient;

final class AnalyticsClient {
  final Future<void> Function(String name) logEvent;
  AnalyticsClient({required this.logEvent});
}

final unimplementedAnalyticsClient = AnalyticsClient(
  logEvent: (_) => throw UnimplementedError(_unimplementedError),
);

const _unimplementedError =
    "[Sunlight] Unimplemented analytics client: Did you run SunlightAnalytics.setup?";
