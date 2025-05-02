import 'package:composable_architecture_flutter/composable_architecture_flutter.dart';

var analyticsClient = consoleAnalyticsClient;

final class AnalyticsClient {
  final dynamic Function(String name) logEvent;
  AnalyticsClient({required this.logEvent});
}

final unimplementedAnalyticsClient = AnalyticsClient(
  logEvent: (_) => throw UnimplementedError(),
);

final consoleAnalyticsClient = AnalyticsClient(
  logEvent: (name) => print("Log event named: $name"), //
);

final class Analytcs<State, Action> extends Feature<State, Action> {
  @override
  Reducer<State, Action> build() {
    return Reduce(
      (_, action) => Effect.sync(
        () => analyticsClient.logEvent(action.toString()), //
      ),
    );
  }
}
