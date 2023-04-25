// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:fullstore/utils/colors.dart';

class SideMenuItem extends StatefulWidget {
  String title;
  Icon icon;
  Color backgroundColor;
  Color textColor;
  Function()? onTap;
  SideMenuItem({
    super.key,
    this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
    required this.icon,
  });

  @override
  State<SideMenuItem> createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: isHovering ? MyColors.grey : widget.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.icon,
              Text(
                widget.title,
                style: TextStyle(fontSize: 15, color: widget.textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
