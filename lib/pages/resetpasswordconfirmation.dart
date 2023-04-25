import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/custombotton.dart';

class ResetPasswordConfirmation extends StatelessWidget {
  const ResetPasswordConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset('assets/checked.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Reset link sent. Please check your email to continue',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              CustomBotton(
                backgroundColor: MyColors.primaryColor,
                textColor: MyColors.white,
                horizontal: 50,
                vertical: 20,
                title: 'Back',
                onTap: () => back(
                  context: context,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

back({required BuildContext context}) {
  Navigator.pop(context);
}
