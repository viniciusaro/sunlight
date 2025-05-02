import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunlight/src/clients/snapshot_client.dart';

SnapshotClient screenshotSnapshotClient(
  ScreenshotController screenshotController,
) {
  return SnapshotClient(
    getLastInteractionSnapshot: () async {
      final directory = await getApplicationDocumentsDirectory();
      final result = await screenshotController.captureAndSave(directory.path);
      return result ?? "";
    },
  );
}
