import 'package:flutter/material.dart';
import 'package:fullstore/pages/additem.dart';
import 'package:fullstore/pages/products.dart';
import 'package:fullstore/pages/sales.dart';
import 'package:fullstore/providers/sidemenuprovider.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/sidemenuitem.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> screens = [
      AddNewProduct(),
      const Products(),
      const Sales(),
    ];
    return Scaffold(
      body: Consumer<SideMenuProvider>(builder: (context, sidemenu, child) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              width: width * 0.15,
              color: MyColors.black,
              child: Column(
                children: [
                  Image.asset(
                    'assets/foods.png',
                    width: width * 0.1,
                    height: height * 0.1,
                  ),
                  Text(
                    'FINGER LICKING',
                    style: TextStyle(
                      color: MyColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SideMenuItem(
                    onTap: () => sidemenu.currentIndex = 0,
                    backgroundColor: sidemenu.currentIndex == 0
                        ? MyColors.primaryColor
                        : MyColors.white,
                    textColor: sidemenu.currentIndex == 0
                        ? MyColors.white
                        : MyColors.black,
                    title: 'Add Item',
                    icon: Icon(
                      Icons.add,
                      color: sidemenu.currentIndex == 0
                          ? MyColors.white
                          : MyColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SideMenuItem(
                    onTap: () => sidemenu.currentIndex = 1,
                    backgroundColor: sidemenu.currentIndex == 1
                        ? MyColors.primaryColor
                        : MyColors.white,
                    textColor: sidemenu.currentIndex == 1
                        ? MyColors.white
                        : MyColors.black,
                    title: 'Products',
                    icon: Icon(
                      Icons.category,
                      color: sidemenu.currentIndex == 1
                          ? MyColors.white
                          : MyColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SideMenuItem(
                    onTap: () => sidemenu.currentIndex = 2,
                    backgroundColor: sidemenu.currentIndex == 2
                        ? MyColors.primaryColor
                        : MyColors.white,
                    textColor: sidemenu.currentIndex == 2
                        ? MyColors.white
                        : MyColors.black,
                    title: 'Sales',
                    icon: Icon(
                      Icons.point_of_sale,
                      color: sidemenu.currentIndex == 2
                          ? MyColors.white
                          : MyColors.black,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: screens[sidemenu.currentIndex],
            )
          ],
        );
      }),
    );
  }
}
