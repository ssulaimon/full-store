// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/models/usermodel.dart';
import 'package:fullstore/providers/usergender.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/widgets/custombotton.dart';
import 'package:fullstore/widgets/customsnackbar.dart';
import 'package:fullstore/widgets/dropdown.dart';
import 'package:fullstore/widgets/mobiletextform.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.white,
        iconTheme: IconThemeData(
          color: MyColors.black,
        ),
        title: Text(
          'Create Account',
          style: TextStyle(color: MyColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                MobileTextForm(
                  validator: (value) =>
                      nameValidator(name: 'First name', value: value!),
                  hint: 'First Name',
                  controller: firstName,
                  label: 'First Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MobileTextForm(
                  validator: (value) =>
                      nameValidator(name: 'Last name', value: value!),
                  hint: 'Last Name',
                  controller: lastName,
                  label: 'Last Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MobileTextForm(
                  validator: (value) => emailValidator(value: value!),
                  hint: 'Email',
                  controller: email,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                MobileTextForm(
                  validator: (value) => passwordValidator(value: value!),
                  hint: 'Password',
                  controller: password,
                  label: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<UserGender>(
                  builder: (context, userGender, child) {
                    return CustomDropDown(
                      validator: (value) => dropDownValidator(value: value),
                      hint: 'Gender',
                      onchanged: (value) {
                        userGender.userGender = value;
                      },
                      items: userGender.genders,
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomBotton(
                  backgroundColor: MyColors.grey,
                  textColor: MyColors.white,
                  horizontal: 70,
                  vertical: 20,
                  title: 'Create Account',
                  onTap: () => createAccount(
                    password: password.text,
                    firstName: firstName.text,
                    lastName: lastName.text,
                    email: email.text,
                    gender: Provider.of<UserGender>(
                      context,
                      listen: false,
                    ).userGender!,
                    key: _key,
                    context: context,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

createAccount(
    {required BuildContext context,
    required GlobalKey<FormState> key,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender}) async {
  if (key.currentState!.validate()) {
    UserModel userModel = UserModel(
      password: password,
      firstName: firstName,
      email: email,
      gender: gender,
      lastName: lastName,
    );
    String create = await UserAuthentication.createAccount(
      userModel: userModel,
    );
    if (create == 'Account created') {
      Navigator.pushNamed(context, PagesRoutes.comfirmation,
          arguments: {'message': 'Your account has been successfuly created'});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: create,
        ),
      );
    }
  }
}

String? nameValidator({required String name, required String value}) {
  if (value.isEmpty) {
    return '$name cannot be empty';
  } else if (value.length < 3) {
    return '$name is too short';
  } else {
    return null;
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

String? dropDownValidator({String? value}) {
  if (value == null) {
    return 'Please choose a gender';
  } else {
    return null;
  }
}
