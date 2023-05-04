import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/providers/shoppinglist.dart';
import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/utils/routes.dart';

import 'package:fullstore/widgets/categoryconatiner.dart';
import 'package:fullstore/widgets/itemscard.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      backgroundColor: MyColors.backgroudColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: MyColors.black,
            ),
          )
        ],
        elevation: 0.0,
        backgroundColor: MyColors.backgroudColor,
        title: Text(
          "Shopping",
          style: TextStyle(color: MyColors.black),
        ),
      ),
      body: Column(
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
                        List<ItemModel> items =
                            snapshot.data as List<ItemModel>;

                        return GridView.builder(
                          itemCount: items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 0.1, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return ItemsCard(
                              onTap: () {
                                Provider.of<ShoppingList>(context,
                                        listen: false)
                                    .addItem(itemModel: items[index]);
                                Provider.of<ShoppingLenght>(context,
                                        listen: false)
                                    .lenght = Provider.of<ShoppingList>(context,
                                        listen: false)
                                    .item
                                    .length;
                              },
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, PagesRoutes.shopping),
        label: Text(
          Provider.of<ShoppingLenght>(
            context,
          ).lenght.toString(),
          style: TextStyle(
            color: MyColors.white,
          ),
        ),
        icon: Icon(
          Icons.shopping_bag,
          color: MyColors.white,
        ),
        backgroundColor: MyColors.primaryColor,
      ),
    );
  }
}
