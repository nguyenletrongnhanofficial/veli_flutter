import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';

import '../../../utils/app_color.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';
import '../widgets/auth_page_link.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  TextEditingController userName = TextEditingController(text: '');
  TextEditingController phoneNumber = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 90.0),
              child: const Text(
                'Tạo tài khoản',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkblueColor,
                ),
                textAlign: TextAlign.center,
              ),
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
            AuthFormTextField(
              label: 'Họ và tên',
              hint: 'Nguyễn Văn A',
              controller: userName,
            ),
            const SizedBox(height: 10),
            AuthFormTextField(
              label: 'Số điện thoại',
              hint: 'Nhập số điện thoại',
              controller: phoneNumber,
            ),
            const SizedBox(height: 10),
            AuthFormTextField(
              label: 'Mật khẩu',
              hint: 'Nhập mật khẩu',
              obscureText: true,
              controller: password,
            ),
            const SizedBox(height: 20),
            AuthActionButton(
              text: 'Đăng ký',
              onPressed: () {
                print(userName.text);
                print(phoneNumber.text);
                print(password.text);
                signUp(context, userName.text, password.text, phoneNumber.text);
                // Xử lý BE
              },
            ),
            // AuthActionButton(
            //   text: 'Đăng ký bằng Google',
            //   onPressed: () {
            //     print(userName.text);
            //   },
            //   backgroundColor: const Color(0xFFEFEFEF),
            //   icon: Image.asset(
            //     'assets/images/logo_google.png',
            //     height: 20,
            //     width: 20,
            //   ),
            //   textColor: Colors.black,
            // ),
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
      )),
    );
  }
}

void signUp(BuildContext context, String userName, String password,
    String phoneNumber) async {
  try {
    final response = await http.post(Uri.parse('$apiHost/api/auth/register'),
        body: {
          'full_name': userName,
          'password': password,
          'phone': phoneNumber
        });

    if (response.statusCode == 201) {
      print('Dang ky thanh cong');
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Đăng Ký thành công",
      );
    } else {
      print(jsonDecode(response.body)["message"]);
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"],
      );
    }
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
      msg: "Thông tin đăng ký không hợp lệ",
    );
  }
}
