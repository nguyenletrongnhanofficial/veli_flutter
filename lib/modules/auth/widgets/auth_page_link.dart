import 'package:flutter/material.dart';

class AuthPageLink extends StatelessWidget {
  const AuthPageLink({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bạn $text?'),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text == "chưa có tài khoản" ? "Đăng ký" : "Đăng nhập",
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
