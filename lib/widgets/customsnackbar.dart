import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

SnackBar customSnackBar({required String message}) {
  return SnackBar(
    content: Text(message),
  );
}
