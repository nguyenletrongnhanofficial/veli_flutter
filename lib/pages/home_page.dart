import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:veli_flutter/modules/profile/pages/profile_page.dart';
import 'package:veli_flutter/modules/save/save_page.dart';
import 'package:veli_flutter/modules/setting/pages/setting_page.dart';
import '../utils/app_color.dart';
import '../widgets/new_document.dart';
import 'package:veli_flutter/modules/description/pages/description_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarHeight = 70.0;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  ScrollController controllerPagination = ScrollController();

  @override
  void initState() {
    super.initState();
    controllerPagination.addListener(myScroll);
  }

  @override
  void dispose() {
    controllerPagination.removeListener(myScroll);
    controllerPagination.dispose();
    super.dispose();
  }

  void myScroll() async {
    controllerPagination.addListener(() {
      final direction = controllerPagination.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (direction == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  void hideBottomBar() {
    setState(() {
      _showAppbar = false;
    });
  }

  void showBottomBar() {
    setState(() {
      _showAppbar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.decelerate,
          height: _showAppbar ? 70 : 0,
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin Chào',
                      style: TextStyle(
                        color: AppColor.darkblueColor,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Name.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'Trang cá nhân') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        } else if (value == 'Đã Lưu') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavePage(),
                            ),
                          );
                        } else if (value == 'Cài đặt') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'Trang cá nhân',
                          child: Text('Trang cá nhân'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Đã Lưu',
                          child: Text('Đã Lưu'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Cài đặt',
                          child: Text('Cài đặt'),
                        ),
                      ],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/image_avt_default.jpg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColor.backgroundColor,
        child: CustomScrollView(
          controller: controllerPagination,
          cacheExtent: 100,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Tài liệu mới',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkblueColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Descriptionpage(),
                        ),
                      );
                    },
                    child: NewDocument(),
                  );
                },
                childCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
