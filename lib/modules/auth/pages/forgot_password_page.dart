import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';

import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';

class ForgotpassPage extends StatefulWidget {
  const ForgotpassPage({Key? key}) : super(key: key);

  @override
  State<ForgotpassPage> createState() => _ForgotpassPageState();
}

class _ForgotpassPageState extends State<ForgotpassPage> {
  TextEditingController controller = TextEditingController(text: '');

  void getVerifyCode(BuildContext context) async {
    try {
      final response = await http.get(
          Uri.parse('$apiHost/api/auth/forgot-password/${controller.text}'));

      Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      if (response.statusCode == 200) {
        navigatorHelper.changeView(context, RouteNames.updatePasswordOtp,
            params: {'phone': controller.text}, isReplaceName: true);
      }
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/forgot_password.dart - Line: 24: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
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
                child: AuthFormTextField(
                  label: '',
                  controller: controller,
                  hint: 'Nhập số điện thoại của bạn vào đây',
                ),
              ),
              AuthActionButton(
                text: 'Tiếp tục',
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    getVerifyCode(context);
                  }
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
