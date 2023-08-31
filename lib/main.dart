import 'package:flutter/material.dart';
import 'package:veli_flutter/pages/onboadring.dart';

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
      home: const Onboadring(
        key: null,
      ),
    );
  }
}
