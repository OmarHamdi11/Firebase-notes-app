import 'package:flutter/material.dart';

class CustomAuthChooseButton extends StatelessWidget {
  const CustomAuthChooseButton({
    super.key,
    required this.text,
    this.onTap,
    required this.choose,
  });

  final bool choose;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 150,
        decoration: choose
            ? BoxDecoration(
                color: const Color(0xffCCDCF6).withOpacity(.8),
                borderRadius: BorderRadius.circular(30),
              )
            : BoxDecoration(
                color: const Color(0xffCCDCF6).withOpacity(.0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xffCCDCF6),
                  width: 2,
                ),
              ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
