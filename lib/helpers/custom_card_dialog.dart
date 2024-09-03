import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customCardDialog({
  required BuildContext context,
  required String title,
  required String desc,
  required DialogType type,
  String? btnOkText,
  void Function()? btnOkOnPress,
  String? btnCancelText,
  void Function()? btnCancelOnPress,
}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: type,
    title: title,
    desc: desc,
    btnOkText: btnOkText,
    btnOkOnPress: btnOkOnPress,
    btnCancelText: btnCancelText,
    btnCancelOnPress: btnCancelOnPress,
  );
}
