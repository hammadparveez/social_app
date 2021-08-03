import 'package:social_app/src/export.dart';
import 'package:social_app/src/riverpods/login_pod.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthCheckWidget(
      notLoggedInWidget: SignUp(),
      loggedInWidget: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text("Sign Out"),
                    onPressed: () => context.read(loginPod).logOut()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
