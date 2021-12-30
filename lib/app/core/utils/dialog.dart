import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ProgressDialogo {
  // ignore: always_declare_return_types, type_annotate_public_apis
  static show(BuildContext context) => showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black12.withOpacity(0.5),
          child: const CircularProgressIndicator()));

  // ignore: always_declare_return_types, type_annotate_public_apis
  static dissmiss(BuildContext context) => Navigator.pop(context);
}
