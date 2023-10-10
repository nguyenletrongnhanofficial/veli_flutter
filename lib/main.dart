import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';
import 'package:veli_flutter/modules/chat/pages/chat_page.dart';
import 'package:veli_flutter/modules/chat/pages/conversation_page.dart';
import 'package:veli_flutter/modules/description/pages/description_page.dart';
//import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';
import 'package:veli_flutter/modules/post/pages/add_post_page.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/pages/onboadring.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:veli_flutter/pages/splash_page.dart';
import 'package:veli_flutter/routes/router.dart' as main_router;

import 'widgets/nav_bar/nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: main_router.Router.generateRoute,
      home: SplashPage(),
      

      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.transparent,
      //       statusBarIconBrightness: Brightness.dark,
      //       statusBarBrightness: Brightness.light,
      //     ),
      //   ),
      // ),
    );
  }
}

List<Widget> _listOfPage = <Widget>[
  Container(alignment: Alignment.center,child: const HomePage()),
  Container(alignment: Alignment.center, child: Descriptionpage()),
  Container(alignment: Alignment.center, child: AddPostPage()),
  Container(alignment: Alignment.center, child: ConversationPage()),
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
      bottomNavigationBar: buildNavBar(),
    );
  }

  NavBar buildNavBar() {
    return NavBar(
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
          icon: Icons.my_library_books_outlined,
          title: 'Đăng bài',
        ),
        BarItem(
          icon: Icons.message,
          title: 'Tin nhắn',
        ),
      ],
    );
  }
}
