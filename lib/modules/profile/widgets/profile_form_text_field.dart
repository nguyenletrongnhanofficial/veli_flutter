import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

class ProfileFormTextField extends StatefulWidget {
  const ProfileFormTextField({
    required this.label,
    required this.hint,
    this.defaultValue,
    this.obscureText = false,
    this.disable = false,
    this.height,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String label;
  final String hint;
  final String? defaultValue;
  final double? height;
  final bool obscureText;
  final bool disable;
  final TextEditingController controller;

  @override
  State<ProfileFormTextField> createState() => _ProfileFormTextFieldState();
}

class _ProfileFormTextFieldState extends State<ProfileFormTextField> {
  @override
  void initState() {
    // TODO: implement initState
    if (widget.defaultValue != null || widget.defaultValue != '') {
      widget.controller.text = widget.defaultValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 20, 12, 10),
          child: Text(
            widget.label,
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
            height: widget.height != null ? widget.height : 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                enabled: !widget.disable,
                controller: widget.controller,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  enabled: !widget.disable,
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
