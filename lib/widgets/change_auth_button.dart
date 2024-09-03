import 'package:flutter/material.dart';

class ChangeAuthButton extends StatelessWidget {
  const ChangeAuthButton({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.6),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
