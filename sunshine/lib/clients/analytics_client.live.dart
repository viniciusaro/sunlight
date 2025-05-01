import 'package:sunshine/clients/analytics_client.dart';
import 'package:sunshine/clients/board_client.dart';
import 'package:sunshine/clients/snapshot_client.dart';

final snapshotAnalyticsClient = () {
  String? lastId;

  return AnalyticsClient(
    logEvent: (id) async {
      if (id == lastId) {
        return;
      }
      lastId = id;

      final snapshot = await snapshotClient.getLastInteractionSnapshot();
      try {
        final currentImage = await boardClient.getItemWithId(id);
        await boardClient.updateImage(snapshot, item: currentImage, id: id);
      } catch (_) {
        await boardClient.addImage(snapshot, id: id);
      }
    },
  );
}();
