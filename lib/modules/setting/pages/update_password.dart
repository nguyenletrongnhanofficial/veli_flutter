import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/services/local_storage_service.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late bool isPasswordVisibleOld;
  TextEditingController controllerOld = TextEditingController();

  bool isPasswordVisibleNew = false;
  TextEditingController controllerNew = TextEditingController();

  bool isPasswordVisibleRepeat = false;
  TextEditingController controllerRepeat = TextEditingController();

  LocalStorageService localStorage = LocalStorageService();

  void updatePassword() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      dynamic body = {
        'old_password': controllerOld.text,
        'new_password': controllerNew.text,
        'new_password_confirm': controllerRepeat.text,
      };

      final response = await http.post(
        headers: {'authorization': 'Bearer ${user!.accessToken}'},
        Uri.parse('$apiHost/api/auth/change-password/'),
        body: body,
      );

      if (response.statusCode == 200) {
        controllerOld.text = '';
        controllerNew.text = '';
        controllerRepeat.text = '';
        Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      } else {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)["message"],
        );
      }
    } catch (e) {
      print(
          'File: lib/modules/setting/pages/update_password.dart - Line: 37: $e ');
    }
  }

  @override
  void initState() {
    super.initState();

    controllerOld.text = '';
    controllerNew.text = '';
    controllerRepeat.text = '';

    isPasswordVisibleOld = true;
    isPasswordVisibleNew = true;
    isPasswordVisibleRepeat = true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF9F9F9),
        leading: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            alignment: Alignment.centerLeft,
            onPressed: () {
              print('Exit update password page');
              Navigator.pop(context);
            },
            icon: const Image(image: AssetImage('assets/images/arrow.png')),
          ),
        ));

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Cập nhật mật khẩu',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 20,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Mật khẩu cũ',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: Color(0xFF150B3D),
            controller: controllerOld,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 6) {
                return 'Mật khẩu phải có ít nhất 6 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Nhập mật khẩu cũ...',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleOld
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_off.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_on.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleOld = !isPasswordVisibleOld),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleOld,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Mật khẩu mới',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: Color(0xFF150B3D),
            controller: controllerNew,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 6) {
                return 'Mật khẩu phải có ít nhất 6 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Nhập mật khẩu mới...',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleNew
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_off.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_on.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleNew = !isPasswordVisibleNew),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleNew,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Xác nhận mật khẩu',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: Color(0xFF150B3D),
            controller: controllerRepeat,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 6) {
                return 'Mật khẩu phải có ít nhất 6 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Nhập mật khẩu mới...',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleRepeat
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_off.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eye_on.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleRepeat = !isPasswordVisibleRepeat),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleRepeat,
          ),
          !isLandscape
              ? const SizedBox(height: 200)
              : const SizedBox(height: 100),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(213, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  primary: const Color(0xFF0EBF7E),
                  onPrimary: Colors.white),
              child: const FittedBox(
                child: Text(
                  'THAY ĐỔI',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Veli_Bold',
                      fontWeight: FontWeight.w700),
                ),
              ),
              onPressed: () async {
                updatePassword();
                print('Event: Change password');
                print('Old password: ${controllerOld.text}');
                print('New password: Change password ${controllerNew.text}');
                print(
                    'Repeat new pass word: Change password ${controllerRepeat.text}');
              },
            ),
          ),
        ]),
      )),
    );
  }
}
