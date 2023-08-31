import 'package:flutter/material.dart';

class Onboadring extends StatefulWidget {
  const Onboadring({required key}) : super(key: key);

  @override
  State<Onboadring> createState() => _OnboadringState();
}

class _OnboadringState extends State<Onboadring> {
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
                'Veli',
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
                const Text(
                  'Đăng bán tài liệu không dùng đến',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Nếu bạn đang có tài cũ không dùng đến thay vì vứt nó, bạn hãy dùng Veli để đăng và bán nó',
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF0EBF7E),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
