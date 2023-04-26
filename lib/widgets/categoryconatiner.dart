import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

// ignore: must_be_immutable
class CategoriesContainer extends StatelessWidget {
  String image;
  String title;
  CategoriesContainer({required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(9),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: MyColors.grey,
              ),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: Image.asset(
              image,
              height: 50,
              width: 50,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: MyColors.black,
            ),
          )
        ],
      ),
    );
  }
}
