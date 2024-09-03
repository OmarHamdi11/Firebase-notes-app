import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customCardDialog({
  required BuildContext context,
  required String title,
  required String desc,
  required DialogType type,
  void Function()? btnOkOnPress,
  void Function()? btnCancelOnPress,
}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: type,
    title: title,
    desc: desc,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: btnOkOnPress ?? null,
  );
}
