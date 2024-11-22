import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/auth/model/user_model.dart';
import 'package:amazone_clone/core/contants/key.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl =
    "https://4000-idx-shopsy-1727332260757.cluster-a3grjzek65cxex762e4mwrzl46.cloudworkstations.dev";
const String bearedToken =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2Nsb3VkLmdvb2dsZS5jb20vd29ya3N0YXRpb25zIiwiYXVkIjoiaWR4LXNob3BzeS0xNzI3MzMyMjYwNzU3LmNsdXN0ZXItYTNncmp6ZWs2NWN4ZXg3NjJlNG13cnpsNDYuY2xvdWR3b3Jrc3RhdGlvbnMuZGV2IiwiaWF0IjoxNzMyMTg3Njg3LCJleHAiOjE3MzIyNzQwODd9.fmaVQSsK-Hw9yGxgqg5E31yzbTX1VVzAg7keZBTGh3x2eTooqUOQVqSqWKu9uBh8HzzZOVNZfu0CwL4XYwefF4lDOIT0Q1-HiDRz1zAFVqgVIbn4EzOTJArbVivFI2GHLamvhSwOy0iZqW5-qcvb4sH5m1RXBtT40NTem7RvGeWVZu19bNDG93AZVEW_pwHOWd60l5I29lj60xG0lG3PYzzVGYwz85djXjTmOoFObN9sttzIPG_eVQjORlxWiCqmME8EsAI6vIQR4e2Zp9frHvFZHbD1G36vYBwoDrINup7fnsKUqyyxBM-G8JdXiKoTxvG0pV_Y0rMl2JfAIBRdTA";

class AuthService {
  static Future<Either<Failure, User>> userSignUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      log("email $email, name $name");
      String url = "$baseUrl/api/user/signup";
      final response = await http.post(Uri.parse(url),
          body:
              jsonEncode({"email": email, "name": name, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearedToken',
          });
      log("======= status ${response.statusCode} data ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final String accessToken = jsonDecode(response.body)["access_token"];
        sharedPreferences.setString(ConstantKeys.accesToken, accessToken);

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
      final url = Uri.parse("$baseUrl/api/user/signin");
      final response = await http.post(url,
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearedToken',
          });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final String accessToken = jsonDecode(response.body)["access_token"];
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
