import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:amazone_clone/core/contants/token.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

Future<Either<Failure, T>> handlerApiResponse<T>(
    {required String accessToken,
    required String url,
    required String? body,
    required Method call,
    required MapEntry<String, String>? addHeader,
    required T Function(dynamic) successHandler}) async {
  try {
    log("############# 1");
    Map<String, String> header = {
      'Access-Token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    log("############# 2");
    if (addHeader != null) {
      header[addHeader.key] = addHeader.value;
    }
    log("############# 3");

    Response? response;
    if (call == Method.get) {
      response = await http.get(Uri.parse('$baseUrl$url'), headers: header);
    } else if (call == Method.post) {
      response = await http.post(Uri.parse('$baseUrl$url'),
          body: body, headers: header);
    }

    log("############# 4");
    if (response!.statusCode >= 200 && response.statusCode < 300) {
      log("endpoind $url response ${response.body}");

      final result = successHandler(response.body);
      return right(result);
    } else {
      log("failure on url $url #response${response.body}");
      final result = jsonDecode(response.body);

      return left(Failure(errorMessage: result["error"]));
    }
  } catch (e) {
    log("endpoin catch error $e");
    return left(Failure(errorMessage: e.toString()));
  }
}

enum Method {
  get,
  post,
}
