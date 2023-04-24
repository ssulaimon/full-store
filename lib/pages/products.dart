import 'package:flutter/material.dart';
import 'package:fullstore/widgets/productscontainer.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: ListView(
        children: [
          Row(
            children: [
              ProductsContainer(
                image: 'assets/vegetable.png',
                title: 'VEGETABLES',
              ),
              const SizedBox(
                width: 30,
              ),
              ProductsContainer(
                image: 'assets/fruit.png',
                title: 'FRUIT DRINKS',
              ),
              const SizedBox(
                width: 30,
              ),
              ProductsContainer(
                image: 'assets/rice.png',
                title: 'RICE',
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              ProductsContainer(
                image: 'assets/desserts.png',
                title: 'DESSERTS',
              ),
              const SizedBox(
                width: 30,
              ),
              ProductsContainer(
                image: 'assets/snack.png',
                title: 'SNACKS ',
              ),
              const SizedBox(
                width: 30,
              ),
              ProductsContainer(
                image: 'assets/soda.png',
                title: 'SODA',
              )
            ],
          )
        ],
      ),
    );
  }
}
