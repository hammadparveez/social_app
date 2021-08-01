import 'package:social_app/src/export.dart';

//Application Routes
class Routes {
  static const main = "/";
  static const home = "/home";
  static const profile = "/profile";
  static const login = "/login";
  static const signUp = "/signUp";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return GetPageRoute(page: () => Login());
      case Routes.home:
        return GetPageRoute(page: () => Home());
      default:
        return GetPageRoute(page: () => SignUp());
    }
  }
}
