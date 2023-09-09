import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

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
          padding: const EdgeInsets.fromLTRB(22, 20, 12, 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.darkblueColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            width: MediaQuery.of(context).size.width -
                40, // Sử dụng kích thước chiều ngang của màn hình- 40 padding
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
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
        ),
      ],
    );
  }
}
