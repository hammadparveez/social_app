import 'package:social_app/src/export.dart';
import 'package:social_app/src/riverpods/login_pod.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthCheckWidget(
      notLoggedInWidget: SignUp(),
      loggedInWidget: Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
        appBar: AppBar(
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  context.read(loginPod).logOut();
                },
                icon: Icon(Icons.logout),
                label: Text(Strings.signOut)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
