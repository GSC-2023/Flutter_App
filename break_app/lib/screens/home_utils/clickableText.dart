import 'package:flutter/material.dart';

class ClickableUnderlineText extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  ClickableUnderlineText({
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
