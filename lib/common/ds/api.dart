import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:tafsir/common/domain/model/rejection.dart';

const _server = 'https://azan.ru/api/tafsir';

class Api {
  final Client client;

  Api(this.client);

  Future<Either<Rejection, List<T>>> getList<T>(
    String endpoint,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final response = await client.get(Uri.parse('$_server/$endpoint'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>()
            as List<Map<String, dynamic>>;
        return right(parsed.map<T>((json) => fromJson(json)).toList());
      } else {
        throw Exception('API GET List Error: $response');
      }
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }
}
