import 'dart:developer';

import 'package:sunshine/clients/logger_client.dart';

final logLoggerClient = LoggerClient(log: log);
final noneLoggerClient = LoggerClient(log: (_) {});
