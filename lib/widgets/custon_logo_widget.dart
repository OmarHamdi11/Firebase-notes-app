import 'package:flutter/material.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    super.key,
    required this.logoLink,
    this.onTap,
  });

  final String logoLink;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: AssetImage(
              logoLink,
            ),
          ),
        ),
      ),
    );
  }
}
