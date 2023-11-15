import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColor.mainColor,
    this.textColor = Colors.white,
    this.icon,
    this.width = 500,
    Key? key,
  }) : super(key: key);

  final String text;
  final double width;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: width,
      height: 80,
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
