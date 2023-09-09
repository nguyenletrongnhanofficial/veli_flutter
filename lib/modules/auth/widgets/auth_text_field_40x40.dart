import 'package:flutter/material.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField(
      {Key? key,
      required void Function(String value) onChanged,
      required TextEditingController controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
