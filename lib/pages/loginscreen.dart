// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/widgets/custombotton.dart';
import 'package:fullstore/widgets/customsnackbar.dart';
import 'package:fullstore/widgets/mobiletextform.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 70,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/foods.png',
                    height: 200,
                    width: 200,
                  ),
                  MobileTextForm(
                    prefix: const Icon(Icons.mail),
                    validator: (value) => emailValidator(value: value!),
                    hint: 'Enter email address',
                    controller: email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MobileTextForm(
                    obsecure: true,
                    prefix: const Icon(Icons.lock),
                    validator: (value) => passwordValidator(value: value!),
                    hint: 'Enter email password',
                    controller: password,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => resetPassword(context: context),
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: MyColors.primaryColor,
                          ),
                        )),
                  ),
                  CustomBotton(
                    backgroundColor: MyColors.grey,
                    textColor: MyColors.white,
                    horizontal: 70,
                    vertical: 20,
                    title: 'Login',
                    onTap: () => login(
                      context: context,
                      key: _key,
                      email: email.text,
                      password: password.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () => pushToCreateAccount(
                                context: context,
                              ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: MyColors.primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? emailValidator({required String value}) {
  if (value.isEmpty) {
    return 'Email address cannot be empty';
  } else if (!value.contains('@')) {
    return 'Unknown email domain';
  } else {
    return null;
  }
}

String? passwordValidator({required String value}) {
  if (value.isEmpty) {
    return 'Password cannot empty';
  } else if (value.length < 6) {
    return 'Password is not strong';
  } else {
    return null;
  }
}

pushToCreateAccount({required BuildContext context}) {
  Navigator.pushNamed(context, PagesRoutes.createAccount);
}

resetPassword({required BuildContext context}) {
  Navigator.pushNamed(
    context,
    PagesRoutes.resetPassword,
  );
}

login(
    {required GlobalKey<FormState> key,
    required String email,
    required String password,
    required BuildContext context}) async {
  if (key.currentState!.validate()) {
    String result = await UserAuthentication.loginToAccount(
        email: email, password: password);
    if (result == 'logged in') {
      Navigator.popAndPushNamed(context, PagesRoutes.home);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(message: result));
    }
  }
}
