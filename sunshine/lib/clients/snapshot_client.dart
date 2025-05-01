var snapshotClient = unimplementedSnapshotClient;

final class SnapshotClient {
  Future<String> Function() getLastInteractionSnapshot;
  SnapshotClient({required this.getLastInteractionSnapshot});
}

final unimplementedSnapshotClient = SnapshotClient(
  getLastInteractionSnapshot: () {
    throw UnimplementedError();
  },
);
