import 'package:flutter/material.dart';

import 'package:fullstore/utils/colors.dart';

class ItemsCard extends StatelessWidget {
  String name;
  String image;
  String price;
  ItemsCard(
      {super.key,
      required this.name,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: MyColors.white),
      child: Column(
        children: [
          Image.network(
            image,
            height: 100,
            width: 100,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
          ),
          Text(
            "₦$price",
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            decoration: BoxDecoration(
                color: MyColors.red, borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              'Add',
              style: TextStyle(color: MyColors.white),
            ),
          )
        ],
      ),
    );
  }
}
