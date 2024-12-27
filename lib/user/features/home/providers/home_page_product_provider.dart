import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/helpers/access_token.dart';
import 'package:amazone_clone/user/features/home/models/dashboard_model.dart';
import 'package:amazone_clone/user/features/home/services/home_page_services.dart';
import 'package:flutter/foundation.dart';

class HomePageProvider extends ChangeNotifier {
  StateHandler<DashboardModel> _dashbord = StateHandler.initial();
  StateHandler<DashboardModel> get dashboardState => _dashbord;

  set setDashboard(StateHandler<DashboardModel> dashbord) {
    _dashbord = dashbord;

    notifyListeners();
  }

  Future<void> getDashboard() async {
    final String? accessToken = await getAccessToken();
    if (accessToken != null) {
      setDashboard = StateHandler.loading();
      final product =
          await HomePageServices.getDashboard(accessToken: accessToken);

      product.fold((l) => setDashboard = StateHandler.error(l.errorMessage),
          (r) {
        setDashboard = StateHandler.success(r);
      });
    } else {
      setDashboard = StateHandler.error("Failed to authenticate");
    }
  }
}
