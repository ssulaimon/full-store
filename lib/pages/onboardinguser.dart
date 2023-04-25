import 'package:flutter/material.dart';
import 'package:fullstore/providers/onboardingstate.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/widgets/custombotton.dart';
import 'package:fullstore/widgets/onboardingpages.dart';
import 'package:onboarding/onboarding.dart';
import 'package:provider/provider.dart';

class OnboardingUser extends StatelessWidget {
  const OnboardingUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<OnboardingState>(
          builder: (context, onboardingState, child) {
            return Onboarding(
              startPageIndex: 0,
              pages: onboardingPages,
              onPageChange: (index) {
                onboardingState.currentIndex = index;
              },
              footerBuilder: (context, netDragDistance, pagesLength, setIndex) {
                return DecoratedBox(
                  decoration: BoxDecoration(color: MyColors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIndicator(
                          netDragPercent: netDragDistance,
                          indicator: Indicator(
                            activeIndicator:
                                ActiveIndicator(color: MyColors.primaryColor),
                            closedIndicator: ClosedIndicator(
                              color: MyColors.black,
                            ),
                            indicatorDesign: IndicatorDesign.polygon(
                              polygonDesign: PolygonDesign(
                                polygon: DesignType.polygon_circle,
                              ),
                            ),
                          ),
                          pagesLength: pagesLength,
                        ),
                        onboardingState.currentIndex == 1
                            ? CustomBotton(
                                horizontal: 20,
                                vertical: 20,
                                backgroundColor: MyColors.lightBlue,
                                textColor: MyColors.white,
                                title: 'Continue',
                                onTap: () => pushTologin(context: context),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

pushTologin({required BuildContext context}) {
  Navigator.popAndPushNamed(
    context,
    PagesRoutes.userLogin,
  );
}
