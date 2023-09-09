import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/forgot_password_page.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/utils/app_color.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';
import '../widgets/auth_page_link.dart';
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chào mừng đã trở lại!',
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
                'Veli và nơi để bạn có thể đăng bán bất kỳ tài liệu nào mà bạn không dùng đến',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.darkblueColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Text(
                        'Nhớ đăng nhập',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 35),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotpassPage()),
                      );
                    },
                    child: const Text(
                      'Quên mật khẩu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AuthActionButton(
              text: 'Đăng nhập',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            AuthActionButton(
              text: 'Đăng nhập bằng Google',
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
              text: 'chưa có tài khoản',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
