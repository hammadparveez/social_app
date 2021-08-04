import 'package:social_app/src/export.dart';
import 'package:social_app/src/model/todo_item_model.dart';
import 'package:social_app/src/riverpods/login_pod.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  _onTap(BuildContext context) async {
    final todo = TodoItemModel();
    await todo.addToDoCollection("hammadpervez6@gmail.com");
    todo.addItem("Mason Brian is awesome");
  }

  @override
  Widget build(BuildContext context) {
    return AuthCheckWidget(
      notLoggedInWidget: const Login(),
      loggedInWidget: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => _onTap(context), child: Icon(Icons.add)),
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
