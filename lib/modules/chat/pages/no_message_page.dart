import 'package:flutter/material.dart';

class NoMessagePage extends StatelessWidget {
  const NoMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/image_nomesage.jpg',
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            'Không có tin nhắn',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Bạn không có tin nhắn mua bán nào ở đây',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
