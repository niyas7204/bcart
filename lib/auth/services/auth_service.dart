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
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2Nsb3VkLmdvb2dsZS5jb20vd29ya3N0YXRpb25zIiwiYXVkIjoiaWR4LXNob3BzeS0xNzI3MzMyMjYwNzU3LmNsdXN0ZXItYTNncmp6ZWs2NWN4ZXg3NjJlNG13cnpsNDYuY2xvdWR3b3Jrc3RhdGlvbnMuZGV2IiwiaWF0IjoxNzMyNTMxNTU3LCJleHAiOjE3MzI2MTc5NTd9.jp-CxVVeVJHOLmoBiBqKRRqbhqEb3FEeRbGif893mnkbOOOzlKn_JrSkqCayeS80XcS69HrLdmt5YsG_dL55GntUE3DjBzqh37_JEOns9UHLf5r7yet6B2LPJvk04j9Rfbu_OsI_BKdEsMw0gyyY1KaJTTuRq-LFQcxF4VeGPhjBuZMTqLb8b7JWk5iijALlZpiKKZtQ_tk2Z-hZMe0gKZ6PIgD61d4UybfS8mjBHCIDcKeg003sPJTgYnOvDpEab7nAKdr8t3ZAwi8DE_E58GMBHpmE4tr6WZTieedUsul3z2wQd2Vqa9HNJvSRYzXsDLMA4Tj5jFhMEex1nZcamg";

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
      final url = Uri.parse("$baseUrl/api/user/signin");
      final response = await http.post(url,
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearedToken',
          });
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