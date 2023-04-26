import 'package:flutter/cupertino.dart';

import 'package:fullstore/widgets/categoryconatiner.dart';
import 'package:fullstore/widgets/itemscard.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoriesContainer(
                image: 'assets/vegetable_grey.png',
                title: 'Vegetable',
              ),
              CategoriesContainer(
                image: 'assets/desserts_grey.png',
                title: 'Desserts',
              ),
              CategoriesContainer(
                image: 'assets/snack_grey.png',
                title: 'Snack',
              ),
              CategoriesContainer(
                image: 'assets/soda_grey.png',
                title: 'Soda',
              ),
              CategoriesContainer(
                image: 'assets/rice_grey.png',
                title: 'Rice',
              ),
              CategoriesContainer(
                image: 'assets/fruit_drink_grey.png',
                title: 'Fruit Drink',
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
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: const [ItemsCard(), ItemsCard()],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
