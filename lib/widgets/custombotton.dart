import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

// ignore: must_be_immutable
class CustomBotton extends StatelessWidget {
  String title;
  Function()? onTap;
  double vertical;
  double horizontal;
  Color backgroundColor;
  Color textColor;
  CustomBotton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.horizontal,
    required this.vertical,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
