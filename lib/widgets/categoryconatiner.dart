import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

class CategoriesContainer extends StatelessWidget {
  String image;
  String title;
  CategoriesContainer({required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.grey,
              ),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: Image.asset(image),
          ),
          Text(title)
        ],
      ),
    );
  }
}
