import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/widgets/auth_action_button.dart';

class NoSaving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                'Không có tài liệu được lưu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Bạn chưa lưu bất kỳ tài liệu nào. Nhấn biểu tượng lưu để lưu nhanh tài liệu mà bạn thích.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Image.asset(
                'assets/images/nosaving.png',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 50,
              ),
              AuthActionButton(
                text: 'TÌM TÀI LIỆU',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
