import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.child,
    this.onTap,
    this.width,
    this.height,
  });
  final Widget child;
  final Color? backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: child,
      ),
    );
  }
}
