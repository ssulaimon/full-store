import 'package:flutter/cupertino.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:onboarding/onboarding.dart';

List<PageModel> onboardingPages = [
  PageModel(
    widget: DecoratedBox(
      decoration: BoxDecoration(color: MyColors.white),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/african_food.png'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                'African Taste',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: MyColors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                'Get African best delicacy from the comfort of your home quick and easy',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  PageModel(
      widget: DecoratedBox(
    decoration: BoxDecoration(color: MyColors.white),
    child: SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/ordering.png'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Comfortable',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: MyColors.black),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Fast and easy ordering process',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    ),
  ))
];
