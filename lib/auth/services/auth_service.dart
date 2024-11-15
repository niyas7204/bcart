import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/auth/model/user_model.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    "https://4000-idx-shopsy-1727332260757.cluster-a3grjzek65cxex762e4mwrzl46.cloudworkstations.dev";
const String bearedToken =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2Nsb3VkLmdvb2dsZS5jb20vd29ya3N0YXRpb25zIiwiYXVkIjoiaWR4LXNob3BzeS0xNzI3MzMyMjYwNzU3LmNsdXN0ZXItYTNncmp6ZWs2NWN4ZXg3NjJlNG13cnpsNDYuY2xvdWR3b3Jrc3RhdGlvbnMuZGV2IiwiaWF0IjoxNzMxNDAzNDMwLCJleHAiOjE3MzE0ODk4Mjl9.IBaejBLbLkcqQmgJ7NPpi-qc7V7h8yaaKbyHu0IYsxNJnnhX-HCOwHw5nw4_bnPs1Bny5wHp_K4jLjI2e2nmaRSf_qHV4Ea9cU669DYdzguPzE19l5snsTfS_AxD8iKTBRid2hl2jI6fTKibf0-uFuU4fD1GRn3zqtLArp7FzB_vEdnSSnZYcNHnzncx3FmZdCsIzPd4vs5K2mi022dCEshtj-IBvS59PtV-rCnU28H2JFqrR4N4wTqRMI-yTV0V8gwFg2Gzj75Z8BKqsd6J0tDOUPZAXwJwc0tZRfW0CAFFLScyCGxPgVJCPCWp3WF1ZJ7su_eYJ6nYrNf_PCN2Hg";

class AuthService {
  static Future<Either<Failure, User>> userSignUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      log("email $email, name $name");
      String url = "$baseUrl/api/user/signup";
      final response = await http.post(Uri.parse(url),
          body:
              jsonEncode({"email": email, "name": name, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearedToken',
          });
      log("======= status ${response.statusCode} data $response");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return right(User.fromJson(response.body));
      } else {
        log("Signup Failure ${response.body}");
        final result = jsonDecode(response.body);
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
      final url = Uri.parse("$baseUrl/api/user/signin");
      final response = await http.post(url,
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearedToken',
          });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return right(User.fromJson(response.body));
      } else {
        log("Signin Failure ${response.body}");
        final result = jsonDecode(response.body);
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("Signin catch $e");
      return left(Failure(errorMessage: "temporerly un avilable"));
    }
  }
}
