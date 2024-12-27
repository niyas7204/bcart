import 'dart:developer';

import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:amazone_clone/core/helpers/response_handler.dart';
import 'package:amazone_clone/user/core/user_urls.dart';
import 'package:amazone_clone/user/features/home/models/dashboard_model.dart';
import 'package:dartz/dartz.dart';

class HomePageServices {
  static Future<Either<Failure, DashboardModel>> getDashboard({
    required String accessToken,
  }) async {
    try {
      return await handlerApiResponse<DashboardModel>(
          accessToken: accessToken,
          body: null,
          addHeader: null,
          url: UserUrls.getDashboard,
          successHandler: (p0) {
            return dashboardModelFromJson(p0);
          },
          call: Method.get);
    } catch (e) {
      log("product delete error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }
}
