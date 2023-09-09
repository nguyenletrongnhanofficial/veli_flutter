import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';

import '../../../utils/app_color.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';
import '../widgets/auth_page_link.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tạo tài khoản',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.darkblueColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Tạo nhanh tài khoản Veli để sử dụng',
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const AuthFormTextField(
              label: 'Họ và tên',
              hint: 'Nguyễn Văn A',
            ),
            const SizedBox(height: 10),
            const AuthFormTextField(
              label: 'Số điện thoại',
              hint: 'Nhập số điện thoại',
            ),
            const SizedBox(height: 10),
            const AuthFormTextField(
              label: 'Mật khẩu',
              hint: 'Nhập mật khẩu',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AuthActionButton(
              text: 'Đăng ký',
              onPressed: () {
                // Xử lý BE
              },
            ),
            AuthActionButton(
              text: 'Đăng ký bằng Google',
              onPressed: () {
                // Xử lý BE
              },
              backgroundColor: const Color(0xFFEFEFEF),
              icon: Image.asset(
                'assets/images/logo_google.png',
                height: 20,
                width: 20,
              ),
              textColor: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            AuthPageLink(
              text: 'đã có tài khoản',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
