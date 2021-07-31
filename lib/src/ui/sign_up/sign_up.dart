import 'package:social_app/src/export.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _userNameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();

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
        //Username
        _formField(_userNameController, Strings.enterUsername),
        //Email
        _formField(_emailController, Strings.enterEmail),
        //Password
        _formField(_passwordController, Strings.enterPass),
        //Confirm Password
        _formField(_confirmPasswordController, Strings.enterConfirmPass),

        _buildSignUpButton(),
        _buildTextButton()
      ],
    );
  }

  TextButton _buildTextButton() =>  TextButton(onPressed: () => Get.toNamed(Routes.login), child: const Text(Strings.alreadyHaveAccount));

  ElevatedButton _buildSignUpButton() {
    return ElevatedButton(
        onPressed: () {},
        child: const Text(Strings.signUp),
      );
  }

  CustomTextField _formField(
      TextEditingController controller, String hintText) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
    );
  }
}
