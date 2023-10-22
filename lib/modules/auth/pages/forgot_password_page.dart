import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/otp_page.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';

class ForgotpassPage extends StatelessWidget {
  const ForgotpassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/image_forgot_pass.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Quên',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Mật khẩu?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Đừng lo! Vui lòng nhập số điện thoại chúng tôi sẽ gửi OTP vào số điện thoại này.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const AuthFormTextField(
                label: '',
                hint: 'Nhập số điện thoại của bạn vào đây',
              ),
            ),
            AuthActionButton(
              text: 'Tiếp tục',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPPage(params: {},)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
