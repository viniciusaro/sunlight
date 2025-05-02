import 'package:http/http.dart' as http;

import 'number_fact_client.dart';

final numbersApiNumberFactClient = NumberFactClient(
  factFor: (number) async {
    final uri = Uri.parse("http://numbersapi.com/$number/trivia");
    final response = await http.get(uri);
    return response.body;
  },
);
