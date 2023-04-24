// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/widgets/admintextform.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                width: width * 0.4,
                height: height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    width: 5,
                    color: MyColors.primaryColor,
                  ),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'FINGER LICKING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Sigin in to Admin Panel',
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: MyColors.grey,
                        decorationThickness: 2.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: AdninTextForm(
                          validator: (value) => emailValidator(
                                value!,
                              ),
                          hint: 'Please enter email',
                          controller: email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: AdninTextForm(
                        validator: (value) => passwordValidator(
                          value!,
                        ),
                        hint: 'Please enter password',
                        controller: password,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.popAndPushNamed(
                        context,
                        PagesRoutes.adminpanel,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          color: MyColors.primaryColor,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: MyColors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * 0.27,
              top: height * 0.3,
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                height: height * 0.5,
                width: width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: MyColors.primaryColor,
                ),
                child: Column(
                  children: [
                    Text(
                      'Hello there!!',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Only registered admin can have access.\nPlease contact developer for access.',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                      ),
                    ),
                    Image.asset(
                      'assets/foods.png',
                      height: 150,
                      width: 150,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String? emailValidator(String text) {
  if (text.isEmpty) {
    return 'Email cannot be empty';
  } else if (text != 'adminuser@admin.com') {
    return 'user not found. Please user registed email';
  } else if (!text.contains('@')) {
    return 'Wrong email type';
  } else {
    return null;
  }
}

String? passwordValidator(String text) {
  if (text.isEmpty) {
    return 'Password cannot be empty';
  } else if (text.length < 5) {
    return 'Password is too short';
  } else {
    return null;
  }
}
