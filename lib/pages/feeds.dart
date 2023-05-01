import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/utils/colors.dart';

import 'package:fullstore/widgets/categoryconatiner.dart';
import 'package:fullstore/widgets/itemscard.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  String category = "vegetable";

  void changeCategory({required String name}) {
    category = name;
    setState(() {});
    print(category);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoriesContainer(
                onTap: () => changeCategory(name: 'vegetable'),
                image: 'assets/vegetable_grey.png',
                title: 'Vegetable',
              ),
              CategoriesContainer(
                onTap: () => changeCategory(name: 'Desserts'),
                image: 'assets/desserts_grey.png',
                title: 'Desserts',
              ),
              CategoriesContainer(
                onTap: () => changeCategory(name: 'Snack'),
                image: 'assets/snack_grey.png',
                title: 'Snacks',
              ),
              CategoriesContainer(
                onTap: () => changeCategory(name: 'Soda'),
                image: 'assets/soda_grey.png',
                title: 'Soda',
              ),
              CategoriesContainer(
                onTap: () => changeCategory(name: 'Rice'),
                image: 'assets/rice_grey.png',
                title: 'Rice',
              ),
              CategoriesContainer(
                onTap: () => changeCategory(name: 'Fruit Juice'),
                image: 'assets/fruit_drink_grey.png',
                title: 'Fruit Juice',
              )
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: FutureBuilder(
                  future: UploadItem.getItems(collectionPath: category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      );
                    } else {
                      List<ItemModel> items = snapshot.data as List<ItemModel>;

                      return GridView.builder(
                        itemCount: items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 0.1, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return ItemsCard(
                            name: items[index].name,
                            price: items[index].price,
                            image: items[index].image,
                          );
                        },
                      );
                    }
                  },
                )))
      ],
    );
  }
}
