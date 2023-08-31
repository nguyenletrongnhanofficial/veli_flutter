import 'package:flutter/material.dart';

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
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 230, 10),
              child: Text(
                'Họ và tên',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: 300,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Nguyễn Văn A',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 205, 10),
              child: Text(
                'Số điện thoại',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: 300,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập số điện thoại',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 230, 10),
              child: Text(
                'Mật khẩu',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: 300,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // BE MK
                    },
                    child: const Icon(Icons.visibility_off),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 500,
              height: 100,
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý BE
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EBF7E),
                ),
                child: const Text('Đăng ký'),
              ),
            ),
            Container(
              width: 500,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý BE
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFEFEF),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo_google.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 20,
                        height: 0,
                      ),
                      const Text(
                        'Đăng ký bằng Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bạn đã có tài khoản?'),
                TextButton(
                  onPressed: () {
                    // BE
                  },
                  child: const Text(
                    'Đăng nhập ngay',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
