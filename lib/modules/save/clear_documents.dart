import 'package:flutter/material.dart';

class ClearDocuments extends StatefulWidget {
  const ClearDocuments({Key? key}) : super(key: key);

  @override
  State<ClearDocuments> createState() => _LogOutState();
}

class _LogOutState extends State<ClearDocuments> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: mediaQuery.size.width,
        height: !isLandscape
            ? (mediaQuery.size.height - mediaQuery.padding.top) / 2
            : (mediaQuery.size.height - mediaQuery.padding.top),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.fromLTRB(29, 0, 24, 29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !isLandscape
                  ? const SizedBox(height: 25)
                  : const SizedBox(height: 0),
              Image.asset('assets/images/divider_bottomsheet.png'),
              Container(
                height: 20,
              ),
              const Text(
                'Xóa tài liệu',
                style: TextStyle(
                    color: Color(0xFF150B3D),
                    fontSize: 16,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 11),
              RichText(
                  text: const TextSpan(
                    text: 'Bạn có chắc xóa tài liệu này không?',
                    style: TextStyle(
                        color: Color(0xFF524B6B),
                        fontSize: 12,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 29),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(317, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    primary: const Color(0xFF0EBF7E),
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'CHẮC CHẮN',
                    style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(317, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    primary: const Color(0xFFF5F7FA),
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'HỦY',
                    style: TextStyle(
                        //height: 26,
                        letterSpacing: 2,
                        color: Color(0XFF243656),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
