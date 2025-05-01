import 'package:mutex/mutex.dart';
import 'package:sunshine/clients/logger_client.dart';

var boardClient = unimplementedBoardClient;

typedef Item = Map<String, dynamic>;

final class BoardClient {
  Future<String> Function(String path, {required String id}) addImage;
  Future<String> Function(String path, {required Item item, required String id})
  updateImage;
  Future<int> Function() lastItemOffset;
  Future<Item> Function(String id) getItemWithId;
  Future<List<Item>> Function() getAllItems;

  BoardClient({
    required this.addImage,
    required this.updateImage,
    required this.lastItemOffset,
    required this.getItemWithId,
    required this.getAllItems,
  });
}

final unimplementedBoardClient = BoardClient(
  addImage: (path, {String? id}) {
    throw UnimplementedError(unimplementedBoardClientErrorMessage);
  },
  updateImage: (path, {required Item item, required String id}) {
    throw UnimplementedError(unimplementedBoardClientErrorMessage);
  },
  lastItemOffset: () {
    throw UnimplementedError(unimplementedBoardClientErrorMessage);
  },
  getItemWithId: (id) {
    throw UnimplementedError(unimplementedBoardClientErrorMessage);
  },
  getAllItems: () {
    throw UnimplementedError(unimplementedBoardClientErrorMessage);
  },
);

const unimplementedBoardClientErrorMessage =
    "[Sunshine] Unimplemented board client: Did you run SunshineAnalytics.setup?";

extension BoardClientLocked on BoardClient {
  BoardClient get locked {
    final mutex = Mutex();
    return BoardClient(
      addImage: (path, {required id}) {
        return mutex.protectThrowing(() => addImage(path, id: id));
      },
      updateImage: updateImage,
      lastItemOffset: () {
        return mutex.protectThrowing(() => lastItemOffset());
      },
      getItemWithId: (id) {
        return mutex.protectThrowing(() => getItemWithId(id));
      },
      getAllItems: () {
        return mutex.protectThrowing(() => getAllItems());
      },
    );
  }
}

extension BoardClientDebug on BoardClient {
  BoardClient get debug {
    return BoardClient(
      addImage: (path, {required id}) async {
        loggerClient.log("adding image\nid: $id\npath: $path");
        final result = await addImage(path, id: id);
        loggerClient.log("adding image done ($id)");
        return result;
      },
      updateImage: (path, {required id, required item}) async {
        loggerClient.log("updating image\nid: $id\npath: $path");
        final result = await updateImage(path, id: id, item: item);
        loggerClient.log("updating image done ($id)");
        return result;
      },
      lastItemOffset: lastItemOffset,
      getItemWithId: getItemWithId,
      getAllItems: getAllItems,
    );
  }
}

extension on Mutex {
  Future<T> protectThrowing<T>(Future<T> Function() criticalSection) async {
    await acquire();
    try {
      return await criticalSection();
    } catch (_) {
      rethrow;
    } finally {
      release();
    }
  }
}
