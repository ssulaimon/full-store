import 'package:flutter/material.dart';

import 'package:fullstore/utils/colors.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 150,
            width: 170,
            decoration: BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Jollof & Chicken'),
            )),
        Positioned(
          left: 5,
          child: Container(
            alignment: Alignment.topRight,
            height: 100,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/jollof.jpg',
                ),
              ),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: MyColors.white,
                )),
          ),
        ),
        Positioned(
          top: 90,
          left: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.white, borderRadius: BorderRadius.circular(20)),
            child: const Text('\$4.00'),
          ),
        )
      ],
    );
  }
}
