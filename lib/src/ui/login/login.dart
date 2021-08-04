import 'package:social_app/src/export.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthCheckWidget(
      loggedInWidget: const Home(),
      notLoggedInWidget: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _onLogin,
            child: Text(Strings.signIn),
          ),
        ),
      ),
    );
  }

  _onLogin() {
    context.read(loginPod).login("hammadpervez6@gmail.com");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          "Sign In Email Link has been sent, Please Check your Inbox! if you haven't, Tap again"),
      duration: Duration(seconds: 5),
    ));
  }
}
