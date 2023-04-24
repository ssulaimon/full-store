import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  List<String> items;
  String hint;
  String? labeltext;
  String? Function(String?) validator;
  void Function(String?) onchanged;
  CustomDropDown({
    super.key,
    this.labeltext,
    required this.validator,
    required this.hint,
    required this.onchanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 10),
      ),
      decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(color: MyColors.black),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.black, width: 2.0))),
      onChanged: onchanged,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 10),
                ),
              ))
          .toList(),
    );
  }
}
