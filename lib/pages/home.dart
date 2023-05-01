import 'package:flutter/material.dart';
import 'package:fullstore/pages/feeds.dart';
import 'package:fullstore/pages/profile.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/bottomnavstate.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItem = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt,
          ),
          label: 'Orders')
    ];
    return Consumer<BottomNavState>(builder: (context, bottomNavState, child) {
      return Scaffold(
        backgroundColor: MyColors.backgroudColor,
        body: const SafeArea(
          child: Feeds(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItem,
          onTap: (index) {
            bottomNavState.currentIndex = index;
          },
          currentIndex: bottomNavState.currentIndex,
        ),
      );
    });
  }
}
