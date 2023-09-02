import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class PostFormTextField extends StatelessWidget {
  const PostFormTextField({
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 12, 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF150b3d),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
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
        ),
      ],
    );
  }
}
