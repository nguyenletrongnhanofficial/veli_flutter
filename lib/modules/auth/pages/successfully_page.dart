import 'package:flutter/material.dart';

import '../widgets/auth_action_button.dart';

class SuccessfullyPage extends StatelessWidget {
  const SuccessfullyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Thành công',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mật khẩu của bạn đã được cập nhật, vui lòng thay đổi mật khẩu thường xuyên để tránh điều này xảy ra',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/image_Successfully.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 0),
            AuthActionButton(
              text: 'Tiếp tục',
              onPressed: () {
                // Xử lý BE
              },
            ),
            AuthActionButton(
              text: 'Đăng nhập',
              onPressed: () {
                // Xử lý BE
              },
              backgroundColor: const Color(0xFFEFEFEF),
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
