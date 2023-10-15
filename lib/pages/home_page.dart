import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/providers/filter_provider.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';

import '../utils/app_color.dart';
import '../widgets/new_document.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarHeight = 70.0;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  bool isFilterVisible = false;
  ScrollController controllerPagination = ScrollController();
  LocalStorageService localStorage = LocalStorageService();

  UserModel? user;

  Future<void> getUser() async {
    UserModel? userStorage = await localStorage.getUserInfo();
    setState(() {
      user = userStorage;
    });
  }

  @override
  void initState() {
    getUser();
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
    final filterProvider = Provider.of<FilterProvider>(context);

    print(filterProvider.filter);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        color: AppColor.backgroundColor,
        child: CustomScrollView(
          controller: controllerPagination,
          cacheExtent: 100,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Xin Chào',
                            style: TextStyle(
                              color: AppColor.darkblueColor,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '${user?.username}',
                            style: const TextStyle(
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
                          child: GestureDetector(
                            onTap: () {
                              navigatorHelper.changeView(
                                  context, RouteNames.myprofile,
                                  isReplaceName: false);
                            },
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
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/home_banner.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  )
                ]),
              ),
            ),
            SliverToBoxAdapter(
                child: isFilterVisible
                    ? FilterPage()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isFilterVisible = true; //Hiện Filterpage
                          });
                        },
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilterPage()));
                            },
                            child: Text(
                              'Lọc kết quả',
                              style: TextStyle(fontSize: 16),
                            )),
                      )),
            SliverToBoxAdapter(
              // padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
              // sliver: SliverToBoxAdapter(
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      navigatorHelper.changeView(
                          context, RouteNames.description);
                    },
                    child: NewDocument(
                      sellerName: 'Lien',
                      createdAt: '${DateTime.now()}',
                      url:
                          'https://ngthminhdev-resources.s3.ap-southeast-1.amazonaws.com/chat-app/image_book.jpg',
                      address: 'HCM',
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
