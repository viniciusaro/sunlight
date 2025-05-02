## 🧑‍💻 How to Use

1. In your app initialization, set up `sunshine` with the desired options:

```dart
SunshineAnalytics.setup(
  boardClient: miroBoardClient(
    boardId: "your_board_id",
    token: "your_api_token",
  ),
);
```

2. To allow capturing screenshots you need to wrap the entire section you want to be tracked with a custom `Sunshine` widget.

```dart
runApp(
  MaterialApp(
    home: Sunshine(
      child: Home(),
    ),
  ),
);
```
example: _main.dev.dart_

3. In your current centralized analytics logging, add sunshine logs:

```dart
class CurrentAnalyticsLogger {
  Future<void> logEvent(String name) {
    // current analytics logging.
    return SunshineAnalytics.log(name: name);
  }
}
```