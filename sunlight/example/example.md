## 🧑‍💻 How to Use

1. In your app initialization, set up `sunlight` with the desired options:

```dart
SunlightAnalytics.setup(
  boardClient: miroBoardClient(
    boardId: "your_board_id",
    token: "your_api_token",
  ),
);
```

2. To allow capturing screenshots you need to wrap the entire section you want to be tracked with a custom `Sunlight` widget.

```dart
runApp(
  MaterialApp(
    home: Sunlight(
      child: Home(),
    ),
  ),
);
```
example: _main.dev.dart_

3. In your current centralized analytics logging, add sunlight logs:

```dart
class CurrentAnalyticsLogger {
  Future<void> logEvent(String name) {
    // current analytics logging.
    return SunlightAnalytics.log(name: name);
  }
}
```