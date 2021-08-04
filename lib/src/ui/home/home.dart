import 'package:social_app/src/export.dart';
import 'package:social_app/src/riverpods/login_pod.dart';
import 'package:social_app/src/riverpods/todo_pod.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    super.initState();
    context.read(todoListPod).getAllItems("hammadpervez6@gmail.com");
  }

  _onTap() async {
    context.read(todoListPod).addItem("hammadpervez6@gmail.com", "Brian ");
  }

  @override
  Widget build(BuildContext context) {
    return AuthCheckWidget(
      notLoggedInWidget: const Login(),
      loggedInWidget: Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: _onTap, child: Icon(Icons.add)),
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
            child: Consumer(builder: (context, watch, child) {
              final items = watch(todoListPod).todoItems;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text("${items[index]!.content}"),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
