// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/widgets/admintextform.dart';
import 'package:fullstore/widgets/custombotton.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Profile({super.key});
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    UserAuthentication.dispalyname,
                    style: TextStyle(color: MyColors.white, fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: FutureBuilder(
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColors.lightBlue,
                      ),
                    );
                  } else if (data.hasError) {
                    return const Center(
                      child: Text('Something went wrong !!'),
                    );
                  } else {
                    Map<String, dynamic> profile = data.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: MyColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              UserAuthentication.email,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        UserAuthentication.isVerified
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.done_all,
                                    color: MyColors.green,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Account Verified',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.done_all,
                                    color: MyColors.green,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        sendVerication(context: context),
                                    child: Text(
                                      'Accont not verified click here',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.primaryColor),
                                    ),
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        profile['location'] == null
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: MyColors.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: () => updateLocation(
                                          context: context,
                                          controller: controller,
                                          key: _key),
                                      child: Text(
                                        'Location not set. click here',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: MyColors.primaryColor),
                                      ))
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: MyColors.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    profile['location'],
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: MyColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              profile['gender'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: MyColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () => logout(context: context),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: MyColors.primaryColor),
                                ))
                          ],
                        ),
                      ],
                    );
                  }
                },
                future: UserAuthentication.getuserInformation(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

logout({required BuildContext context}) async {
  await UserAuthentication.logout();
  Navigator.popAndPushNamed(context, PagesRoutes.userLogin);
}

sendVerication({required BuildContext context}) async {
  await UserAuthentication.sendVerification();
  Navigator.pushNamed(context, PagesRoutes.comfirmation, arguments: {
    'message': 'Please check your email to continue',
  });
}

Future<void> updateLocation(
    {required BuildContext context,
    required TextEditingController controller,
    required GlobalKey<FormState> key}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: key,
          child: AlertDialog(
            content: AdninTextForm(
              maxLine: 4,
              validator: (value) => locationValidator(
                value: value!,
              ),
              hint: 'Your Full Address',
              controller: controller,
            ),
            actions: [
              CustomBotton(
                  onTap: () {
                    if (key.currentState!.validate()) {
                      location(
                        locationName: controller.text,
                        context: context,
                      );
                    }
                  },
                  backgroundColor: MyColors.primaryColor,
                  textColor: MyColors.white,
                  horizontal: 10,
                  vertical: 10,
                  title: 'Update Location'),
            ],
          ),
        );
      });
}

String? locationValidator({required String value}) {
  if (value.isEmpty) {
    return 'Location address cannot be empty';
  } else {
    return null;
  }
}

Future<void> location({
  required String locationName,
  required BuildContext context,
}) async {
  UserAuthentication.updateLocation(
    location: locationName,
  );
  Navigator.popAndPushNamed(context, PagesRoutes.comfirmation,
      arguments: {'message': 'Location Updated'});
}
