import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/auth/model/user_model.dart';
import 'package:amazone_clone/core/constants/key.dart';
import 'package:amazone_clone/core/constants/token.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Either<Failure, User>> userSignUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      log("email $email, name $name");
      String url = "$baseUrl/api/auth/signup";
      final response = await http.post(Uri.parse(url),
          body:
              jsonEncode({"email": email, "name": name, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearerToken',
          });
      log("======= status ${response.statusCode} data ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final String accessToken = jsonDecode(response.body)["Access-Token"];
        sharedPreferences.setString(ConstantKeys.accesToken, accessToken);
        log("Signup response ${response.body}");
        return right(User.fromJson(response.body));
      } else {
        log("Signup Failure ${response.body}");
        final result = jsonDecode(response.body);
        log("===== ${result["error"]}");
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("Signup catch $e");
      return left(Failure(errorMessage: "temporerly un avilable"));
    }
  }

  static Future<Either<Failure, User>> userSignIn(
      {required String email, required String password}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final url = Uri.parse("$baseUrl/api/auth/signin");
      final response = await http.post(url,
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearerToken',
          });
      log("Signin Failure =${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final String accessToken = jsonDecode(response.body)["Access-Token"];
        sharedPreferences.setString(ConstantKeys.accesToken, accessToken);

        return right(User.fromJson(response.body));
      } else {
        log("Signin Failure ${response.body}");
        final result = jsonDecode(response.body);
        log("===== ${result["error"]}");
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("Signin catch $e");
      return left(Failure(errorMessage: "temporerly un avilable"));
    }
  }

  // Future<Either<Failure, Null>> getUserData() async {
  //   try {
  //     final SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     sharedPreferences.getString(ConstantKeys.accesToken);
  //   } catch (e) {}
  // }
}
// {"message":"Success",
// "access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NDAxYTFiYWQ1Y2RkMGVkOGVkMzA3OSIsImlhdCI6MTczMjI1NTQ3Mn0.2EV6z_anqCZN1JHJ9OnD4FB5hP29J0mA08eJuewCkm4",
// "user":{"_id":"67401a1bad5cdd0ed8ed3079","name":"admin123","email":"admin123@gmail.com","userType":"user","__v":0}}