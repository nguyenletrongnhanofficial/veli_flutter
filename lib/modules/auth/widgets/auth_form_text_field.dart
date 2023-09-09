import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';

class AuthFormTextField extends StatelessWidget {
  const AuthFormTextField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  final String label;
  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColor.darkblueColor,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.black, width: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
