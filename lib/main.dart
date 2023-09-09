import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';
import 'package:veli_flutter/modules/auth/pages/otp_page.dart';
import 'package:veli_flutter/modules/post/pages/add_post_page.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/pages/onboadring.dart';
import 'modules/auth/pages/successfully_page.dart';
import 'widgets/nav_bar/nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

List<Widget> _listOfPage = <Widget>[
  Container(
      alignment: Alignment.center,
      child: const Onboadring(
        key: null,
      )),
  Container(alignment: Alignment.center, child: HomePage()),
  Container(alignment: Alignment.center, child: LoginPage()),
  Container(alignment: Alignment.center, child: AddPostPage()),
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfPage,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        backgroundColor: Colors.white,
        onButtonPressed: onButtonPressed,
        iconSize: 27,
        activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.search_rounded,
            title: 'Tìm kiếm',
          ),
          BarItem(
            icon: Icons.message,
            title: 'Tin nhắn',
          ),
          BarItem(
            icon: Icons.notifications,
            title: 'Thông báo',
          ),
        ],
      ),
    );
  }
}
