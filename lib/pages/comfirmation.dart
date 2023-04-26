import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/custombotton.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    Map message = ModalRoute.of(context)!.settings.arguments as Map;

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
                    Text(
                      message['message'],
                      style: const TextStyle(fontSize: 20),
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
