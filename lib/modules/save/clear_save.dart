import 'package:flutter/material.dart';

class ClearSave extends StatefulWidget {
  const ClearSave({Key? key}) : super(key: key);

  @override
  State<ClearSave> createState() => _LogOutState();
}

class _LogOutState extends State<ClearSave> {
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
              const SizedBox(height: 29),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(317, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  primary: const Color(0xFF0EBF7E),
                  onPrimary: Colors.white,
                ),
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Xóa',
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(317, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  primary: const Color(0xFFF5F7FA),
                  onPrimary: Colors.white,
                ),
                icon: const Icon(Icons.send, color: Colors.yellow),
                label: const Text(
                  'Gửi tin nhắn',
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Color(0XFF243656),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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
