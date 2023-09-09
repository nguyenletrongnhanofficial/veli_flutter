import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/successfully_page.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_countdown.dart';
import '../widgets/otp_text_field.dart';

class OTPPage extends StatelessWidget {
  final TextEditingController otpDigit1Controller = TextEditingController();
  final TextEditingController otpDigit2Controller = TextEditingController();
  final TextEditingController otpDigit3Controller = TextEditingController();
  final TextEditingController otpDigit4Controller = TextEditingController();
  final FocusNode otpDigit1FocusNode = FocusNode();
  final FocusNode otpDigit2FocusNode = FocusNode();
  final FocusNode otpDigit3FocusNode = FocusNode();
  final FocusNode otpDigit4FocusNode = FocusNode();

  OTPPage({super.key});

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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(
                  controller: otpDigit1Controller,
                  focusNode: otpDigit1FocusNode,
                  nextFocusNode: otpDigit2FocusNode,
                ),
                const SizedBox(width: 20),
                OTPTextField(
                  controller: otpDigit2Controller,
                  focusNode: otpDigit2FocusNode,
                  nextFocusNode: otpDigit3FocusNode,
                ),
                const SizedBox(width: 20),
                OTPTextField(
                  controller: otpDigit3Controller,
                  focusNode: otpDigit3FocusNode,
                  nextFocusNode: otpDigit4FocusNode,
                ),
                const SizedBox(width: 20),
                OTPTextField(
                  controller: otpDigit4Controller,
                  focusNode: otpDigit4FocusNode,
                  nextFocusNode:
                      FocusNode(), // Không chuyển tập trung đến ô tiếp theo
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountdownTimer(
                    seconds: 60,
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
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Hành động khi nhấp vào "Gửi lại"
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Không nhận được mã? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Gửi lại',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AuthActionButton(
              text: 'Xác thực',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessfullyPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
