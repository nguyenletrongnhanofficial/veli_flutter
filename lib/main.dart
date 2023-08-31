import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:veli_flutter/pages/onboadring.dart';
import 'package:veli_flutter/pages/sign_up.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(),
      home: const SignupPage(
        key: null,
      ),
    );
  }
}
