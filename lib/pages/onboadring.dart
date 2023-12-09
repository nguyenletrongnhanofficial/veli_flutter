import 'package:flutter/material.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';

import '../utils/app_color.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 30, 25, 40),
              child: const Text(
                '',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/image_starts.png',
                  width: 300.0,
                  height: 300.0,
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Đăng bán tài liệu không dùng đến',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Veli - Nơi trao đổi và mua bán tài liệu, giáo trình Công nghệ thông tin',
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorHelper.changeView(context, RouteNames.login);
        },
        backgroundColor: AppColor.mainColor,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
