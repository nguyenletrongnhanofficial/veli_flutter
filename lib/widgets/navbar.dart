import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/chat/pages/conversation_page.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/modules/post/pages/add_post_page.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/widgets/nav_bar/nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

List<Widget> _listOfPage = <Widget>[
  Container(
      alignment: Alignment.center,
      child: const HomePage(
        key: null,
      )),
  Container(alignment: Alignment.center, child: FilterPage()),
  Container(alignment: Alignment.center, child: ConversationPage()),
  Container(alignment: Alignment.center, child: AddPostPage()),
];

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
