import 'package:flutter/cupertino.dart';
import 'package:fullstore/utils/colors.dart';

// ignore: must_be_immutable
class ProductsContainer extends StatefulWidget {
  String title;
  String image;
  ProductsContainer({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  double width = 200;
  double height = 150;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          width = 250;
          height = 170;
        });
      },
      onExit: (event) {
        setState(() {
          width = 200;
          height = 150;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(
              10,
            )),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.image,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
