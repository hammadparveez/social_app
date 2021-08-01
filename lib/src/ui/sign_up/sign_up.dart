import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:social_app/src/export.dart';
import 'package:social_app/src/riverpods/register_pod.dart';

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
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _createDynamicLink();
    });
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
        _buildHaveAccountBtn()
      ],
    );
  }

  TextButton _buildHaveAccountBtn() => TextButton(
      onPressed: () => Get.toNamed(Routes.login),
      child: const Text(Strings.alreadyHaveAccount));

  void _createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://hsbiz.page.link',
      link: Uri.parse('https://exclusiveinn.com'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.social_app',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.social_app',
        minimumVersion: '1',
        appStoreId: '123',
      ),
    );

    var dynamicUrl = await parameters.buildShortLink();
    final shortUrl = dynamicUrl.shortUrl;
    log("Short Ur:: ${shortUrl}");
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    log("Link : $data");
  }

  void _signUp() async {
    final registerPod = context.read(registerUserPod);

    //await context.read(loginPod).login("hammadpervez6@gmail.com");
    //showAlertDialog(context, CircularProgressIndicator());
    //bool isRegistered = await registerPod.registerUser(_userNameController.text,
    //   _emailController.text, _passwordController.text);
    //Get.back();
    //if (isRegistered) Get.toNamed(Routes.home);
  }

  ElevatedButton _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _signUp,
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
}
