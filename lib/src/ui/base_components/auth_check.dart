import 'package:social_app/src/export.dart';
import 'package:social_app/src/riverpods/login_pod.dart';

class AuthCheckWidget extends StatelessWidget {
  const AuthCheckWidget(
      {Key? key, required this.loggedInWidget, required this.notLoggedInWidget})
      : super(key: key);
  final Widget loggedInWidget, notLoggedInWidget;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _child) {
        if (watch(loginPod).isLoggedIn) return loggedInWidget;
        return notLoggedInWidget;
      },

    );
  }
}
