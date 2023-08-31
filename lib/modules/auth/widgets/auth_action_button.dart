import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColor.mainColor,
    this.textColor = Colors.white,
    this.icon,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 100,
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
