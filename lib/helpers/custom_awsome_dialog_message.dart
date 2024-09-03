import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customAwsomeDialogMessage({
  required BuildContext context,
  required String title,
  required String desc,
  required DialogType type,
  void Function()? btnOkOnPress,
}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: type,
    title: title,
    desc: desc,
    btnOkOnPress: btnOkOnPress,
  );
}
