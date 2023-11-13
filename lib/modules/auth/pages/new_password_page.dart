import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/utils/app_color.dart';

import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';

class NewPasswordPage extends StatefulWidget {
  final Map<String, String>? params;
  NewPasswordPage({Key? key, this.params}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<NewPasswordPage> {
  TextEditingController password = TextEditingController(text: '');

  bool _isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            //padding: EdgeInsets.only(top: 90.0),
            margin: EdgeInsets.only(top: 100.0),
            child: const Text(
              'Hãy đặt lại mật khẩu cho tài khoản của bạn',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.darkblueColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          AuthFormTextField(
            label: 'Mật khẩu',
            hint: 'Nhập mật khẩu',
            obscureText: _isObscure,
            controller: password,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthActionButton(
                text: 'Hoàn tất',
                width: 300,
                onPressed: () async {
                  print(password.text);
                  if (password.text.isNotEmpty) {
                    changePass(password.text);
                  }
                },
              )
            ],
          ),
        ]),
      ),
    ));
  }

  Future<void> changePass(String password) async {
    try {
      final response = await http.post(
          Uri.parse(
              '$apiHost/api/auth/forgot-password/${widget.params!['phone']}'),
          body: {'password': password});

      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"],
      );
      if (response.statusCode == 200) {
        navigatorHelper.changeView(context, RouteNames.successfullypage,
            isReplaceName: true);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Vui lòng kiểm tra số điện thoại và password");
    }
  }
}
