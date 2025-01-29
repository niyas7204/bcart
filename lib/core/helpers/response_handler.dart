import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:amazone_clone/core/constants/token.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';

Future<Either<Failure, T>> handlerApiResponse<T>(
    {required String accessToken,
    required String url,
    required String? body,
    required Method method,
    required MapEntry<String, String>? addHeader,
    required T Function(dynamic) successHandler}) async {
  try {
    Map<String, String> header = {
      'Access-Token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    if (addHeader != null) {
      header[addHeader.key] = addHeader.value;
    }

    http.Response? response;
    switch (method) {
      case Method.get:
        response = await http.get(Uri.parse('$baseUrl$url'), headers: header);
        break;
      case Method.post:
        response = await http.post(Uri.parse('$baseUrl$url'),
            headers: header, body: body);
        break;
      case Method.put:
        response = await http.put(Uri.parse('$baseUrl$url'),
            headers: header, body: body);
        break;
      case Method.patch:
        response = await http.patch(Uri.parse('$baseUrl$url'),
            headers: header, body: body);
        break;
      case Method.delete:
        response = await http.delete(Uri.parse('$baseUrl$url'),
            headers: header, body: body);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // log("endpoind $url status ${response.statusCode} response ${response.body}");

      final result = successHandler(response.body);
      return right(result);
    } else {
      log("failure on url $url status ${response.statusCode}  #response${response.body}");
      final result = jsonDecode(response.body);

      return left(Failure(errorMessage: result["error"]));
    }
  } catch (e) {
    log("endpoin catch error $e");
    return left(Failure(errorMessage: e.toString()));
  }
}

enum Method { get, post, put, delete, patch }
