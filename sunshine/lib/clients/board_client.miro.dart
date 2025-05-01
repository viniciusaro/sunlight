import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'board_client.dart';

BoardClient miroBoardClient({required String boardId, required String token}) {
  late BoardClient self;

  self = BoardClient(
    addImage: (path, {required String id}) async {
      final offset = await self.lastItemOffset();

      final uri = Uri.parse("https://api.miro.com/v2/boards/$boardId/images");
      final request = http.MultipartRequest('POST', uri);
      final file = await http.MultipartFile.fromPath(
        'resource',
        path,
        contentType: MediaType('image', 'png'),
      );

      var jsonString = jsonEncode({
        "title": id,
        "position": {"x": offset, "y": 0},
      });

      var jsonPart = http.MultipartFile.fromString(
        'data',
        jsonString,
        contentType: MediaType('application', 'json'),
      );

      request.files.add(file);
      request.files.add(jsonPart);

      request.headers.addAll({
        "accept": "application/json",
        "Authorization": "Bearer $token",
      });

      final _ = await request.send();
      return id;
    },
    updateImage: (path, {required Item item, required String id}) async {
      final itemId = item["id"];
      final uri = Uri.parse(
        "https://api.miro.com/v2/boards/$boardId/images/$itemId",
      );
      final request = http.MultipartRequest('PATCH', uri);
      final file = await http.MultipartFile.fromPath(
        'resource',
        path,
        contentType: MediaType('image', 'png'),
      );

      var jsonString = jsonEncode({
        "title": id, //
      });

      var jsonPart = http.MultipartFile.fromString(
        'data',
        jsonString,
        contentType: MediaType('application', 'json'),
      );

      request.files.add(file);
      request.files.add(jsonPart);

      request.headers.addAll({
        "accept": "application/json",
        "Authorization": "Bearer $token",
      });

      final _ = await request.send();
      return id;
    },
    lastItemOffset: () async {
      final list = await self.getAllItems();
      return list.length * 1700;
    },
    getItemWithId: (id) async {
      final list = await self.getAllItems();
      return list.firstWhere((value) => value["data"]["title"] == id);
    },
    getAllItems: () async {
      final uri = Uri.parse("https://api.miro.com/v2/boards/$boardId/items");

      final response = await http.get(
        uri,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final json = Map.from(jsonDecode(response.body));
      return List.from(json["data"]);
    },
  );

  return self;
}
