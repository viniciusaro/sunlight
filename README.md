# sunshine

[![pub package](https://img.shields.io/pub/v/sunshine.svg)](https://pub.dev/packages/sunshine_events)

Automated event documentation with screenshots for Flutter applications.
No more spreadsheets or manual logging—just clear, consistent event records sent straight to your team board.

## 🌅 What is sunshine?

`sunshine` is a lightweight Dart package designed to work side by side with your current logging system. It automatically captures a screenshot and sends both the event metadata and image to a central board or endpoint. This helps teams:

- Monitor which events are being sent.
- Reduce the need for manual documentation.
- Improve visibility and QA during development.

## 🔧 Use Case

Ever found yourself wondering:

> - "Which events have we already instrumented?"
> - "Did we forget to document this one?"
> - "Have we documented events sent by the new screen in the flow?"

With sunshine, all these questions are answered. Each time you send an event, a screenshot is captured and pushed with it—making event tracking and QA much simpler.

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

## Production builds

Sending a screenshot for every event fired might become heavy for production builds. That is why we recommend setting sunshine up only for development/internal builds. That is usually enough to cover all app paths without adding overhead to your production users.

> If `SunshineAnalytics.setup` is never called, `SunshineAnalytics.log` becomes a no-op. So your production app stays unaffected.

## 📋 Available Board Integrations

Currently supported:

- ✅ Miro → `miroBoardClient`

Planned:

- [ ] Notion
- [ ] Figma
- [ ] Custom webhook

## 🙋‍♂️ Why "sunshine"?

Just like sunshine makes things clear and visible, this package makes your event flow transparent for your whole team.

## 👏 Contributions

Feel free to open issues or PRs! Feedback, ideas, and use cases are very welcome.
