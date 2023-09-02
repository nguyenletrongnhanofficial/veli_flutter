import 'package:flutter/material.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_countdown.dart';
import '../widgets/auth_text_field_40x40.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/image_otp.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'XÁC THỰC OTP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Nhập mã OTP đã nhận ở SĐT 012345678',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Đặt căn giữa theo chiều ngang
                children: [
                  CountdownTimer(
                    seconds: 120, // Số giây đếm ngược
                    onTimerFinish: () {},
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'giây',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                OTPTextField(),
                SizedBox(width: 20),
                OTPTextField(),
                SizedBox(width: 20),
                OTPTextField(),
                SizedBox(width: 20),
                OTPTextField(),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // BE
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Không nhận được mã? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Gửi lại',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            AuthActionButton(
              text: 'Xác thực',
              onPressed: () {
                // Xử lý BE
              },
            ),
          ],
        ),
      ),
    );
  }
}
