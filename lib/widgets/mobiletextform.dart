// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

class MobileTextForm extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String? label;
  bool? obsecure;
  String? Function(String?) validator;
  Icon? prefix;
  MobileTextForm({
    this.prefix,
    this.obsecure,
    this.label,
    required this.validator,
    required this.hint,
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obsecure ?? false,
      decoration: InputDecoration(
        prefixIcon: prefix,
        errorBorder: const OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: MyColors.black),
        hintText: hint,
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: MyColors.black,
          width: 2.0,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.primaryColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
