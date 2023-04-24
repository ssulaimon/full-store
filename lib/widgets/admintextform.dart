// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fullstore/utils/colors.dart';

class AdninTextForm extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String? label;
  int? maxLine;
  String? Function(String?) validator;
  AdninTextForm({
    this.maxLine,
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
      maxLines: maxLine,
      decoration: InputDecoration(
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
