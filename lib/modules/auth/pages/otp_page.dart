import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/auth/pages/successfully_page.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_countdown.dart';
import 'package:http/http.dart' as http;

import '../widgets/otp_text_field.dart';

class OTPPage extends StatefulWidget {
  final Map<String, String>? params;

  OTPPage({Key? key, this.params}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController otpDigit1Controller = TextEditingController();
  final TextEditingController otpDigit2Controller = TextEditingController();
  final TextEditingController otpDigit3Controller = TextEditingController();
  final TextEditingController otpDigit4Controller = TextEditingController();

  final FocusNode otpDigit1FocusNode = FocusNode();
  final FocusNode otpDigit2FocusNode = FocusNode();
  final FocusNode otpDigit3FocusNode = FocusNode();
  final FocusNode otpDigit4FocusNode = FocusNode();

  LocalStorageService localStorage = LocalStorageService();

  UserModel? user;
  bool isResend = false;

  Future<UserModel?> getUser() async {
    UserModel? userStorage = await localStorage.getUserInfo();
    setState(() {
      user = userStorage;
    });
    return user;
  }

  Future<void> getVerifyCode() async {
    final String? userId = widget.params!["userId"];
    try {
      UserModel? user = await getUser();
      final response = await http.post(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/auth/verify'));
      Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);

    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
      print(e);
    }
  }

  Future<void> sendVerifyCode() async {
    final String? userId = widget.params!["userId"];
    try {
      UserModel? user = await getUser();
      final body = {
        "otp_code":
            "${otpDigit1Controller.text}${otpDigit2Controller.text}${otpDigit3Controller.text}${otpDigit4Controller.text}".toString()
      };

      print(body);

      final response = await http.post(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/auth/verify/$userId'),
          body: body);

      Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      if (response.statusCode == 200) {
        navigatorHelper.changeView(context, RouteNames.main);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    getVerifyCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
              Text(
                'Nhập mã OTP đã nhận ở SĐT ${user?.phone}',
                style: const TextStyle(
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
                      onTimerFinish: () {
                        setState(() {
                          isResend = true;
                        });
                      },
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
                  if (!isResend) {
                    return;
                  }
                  setState(() {
                    isResend = false;
                  });
                  getVerifyCode();
                  // Hành động khi nhấp vào "Gửi lại"
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Không nhận được mã? ',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Gửi lại',
                        style: TextStyle(
                          color: isResend ? Colors.black : Colors.grey,
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
                  sendVerifyCode();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SuccessfullyPage()),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
