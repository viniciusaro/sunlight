var loggerClient = unimplementedLoggerClient;

final class LoggerClient {
  void Function(String) log;
  LoggerClient({required this.log});
}

final unimplementedLoggerClient = LoggerClient(
  log: (_) => throw UnimplementedError(),
);
