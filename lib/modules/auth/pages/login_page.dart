import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/auth/pages/forgot_password_page.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_form_text_field.dart';
import '../widgets/auth_page_link.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  LocalStorageService localStorage = LocalStorageService();
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  Future<void> login(String phoneNumber, String password) async {
    try {
      final response = await http.post(Uri.parse('$apiHost/api/auth/login'),
          body: {'phone': phoneNumber, 'password': password});

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body)["data"];
        print(userJson.toString());
        final user = UserModel.fromJson(userJson);
        await localStorage.setUserInfo(user);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
        );

        if (user.status == 0) {
          navigatorHelper
              .changeView(context, RouteNames.otp, params: {"userId": user.id});
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          navigatorHelper.changeView(context, RouteNames.main,
              isReplaceName: true);
        }
      } else {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)["message"],
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Vui lòng kiểm tra số điện thoại và password");
    }
  }

  void onPressedLogin() async {
    print(phoneNumberController.text);
    print(passwordController.text);
    await login(phoneNumberController.text, passwordController.text);
  }

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
                //padding: EdgeInsets.only(top: 90.0),
                margin: EdgeInsets.only(top: 90.0),
                child: const Text(
                  'Chào mừng đã trở lại!',
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
                  'Veli - nơi trao đổi và mua bán tài liệu, giáo trình Công nghệ thông tin',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.darkblueColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              AuthFormTextField(
                label: 'Số điện thoại',
                hint: 'Nhập số điện thoại',
                controller: phoneNumberController,
              ),
              const SizedBox(height: 10),
              AuthFormTextField(
                label: 'Mật khẩu',
                hint: 'Nhập mật khẩu',
                obscureText: _isPasswordHidden,
                controller: passwordController,
              ),
              // IconButton(
              //     onPressed: _togglePasswordVisibility,
              //     icon: Icon(
              //       _isObscure ? Icons.visibility : Icons.visibility_off,
              //       color: Colors.grey,
              //     )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  // padding: const EdgeInsets.only(left: 35),
                  // child: Row(
                  // children: [
                  // Checkbox(
                  // value: false,
                  // onChanged: (value) {},
                  // ),
                  // const Text(
                  // 'Nhớ đăng nhập',
                  // textAlign: TextAlign.center,
                  // ),
                  // ],
                  // ),
                  // ),
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
                onPressed: onPressedLogin,
              ),

              // AuthActionButton(
              //   text: 'Đăng nhập bằng Google',
              //   onPressed: () {
              //     // Xử lý BE
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
      ),
    );
  }
}
