import 'package:social_app/src/export.dart';
import 'package:social_app/src/ui/login/export.dart';

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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmailField(),
            _buildPasswordField(),
          ],
        ),
      ),
    );
  }

  CustomTextField _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      hintText: Strings.enterPass,
    );
  }

  CustomTextField _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      hintText: Strings.enterEmail,
    );
  }
}
