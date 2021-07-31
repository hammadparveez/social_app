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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  Column _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEmailField(),
        _buildPasswordField(),
        SizedBox(height: 50.sp),
        ElevatedButton(
          onPressed: () {},
          child: Text(Strings.signIn),
        ),
      ],
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
