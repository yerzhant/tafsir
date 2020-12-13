import 'dart:convert';

import 'package:http/http.dart' as http;

const _server = 'https://azan.ru/api/tafsir';

Future<List<T>> apiGet<T>(
  String endpoint,
  T Function(Map<String, dynamic> json) fromJson,
) async {
  final response = await http.get('$_server/$endpoint');

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>()
        as List<Map<String, dynamic>>;
    return parsed.map<T>((json) => fromJson(json)).toList();
  } else {
    throw Exception('API GET Error: $response');
  }
}
