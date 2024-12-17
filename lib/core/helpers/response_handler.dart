import 'dart:convert';
import 'dart:developer';
import 'package:amazone_clone/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:amazone_clone/core/contants/token.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';

Future<Either<Failure, T>> handlerApiResponse<T>(
    {required String accessToken,
    required String url,
    required String? body,
    required MapEntry<String, String>? addHeader,
    required T Function(dynamic) successHandler}) async {
  Map<String, String> header = {
    'Access-Token': accessToken,
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $bearedToken',
  };
  if (addHeader != null) {
    header[addHeader.key] = addHeader.value;
  }
  final response =
      await http.post(Uri.parse('$baseUrl$url'), body: body, headers: header);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    final result = successHandler(response.body);
    return right(result);
  } else {
    log("delete product failure ${response.body}");
    final result = jsonDecode(response.body);

    return left(Failure(errorMessage: result["error"]));
  }
}
