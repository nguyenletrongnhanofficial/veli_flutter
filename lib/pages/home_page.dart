import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/services/socket_service.dart';
import 'package:veli_flutter/widgets/new_document.dart';

import '../utils/app_color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarHeight = 70.0;
  bool isScrollingDown = false;
  bool isFilterVisible = false;
  ScrollController controllerPagination = ScrollController();
  LocalStorageService localStorage = LocalStorageService();
  late SocketService socket;
  UserModel? user;
  List<DocumentModel> documents = [];

  Future<void> initializeSocketService() async {
    UserModel? user = await localStorage.getUserInfo();
    socket = SocketService.getInstance(authorizationToken: user!.accessToken);
    socket.onEvent(
        'connect',
        (data) => print(
            'File: lib/pages/home_page.dart - Line: 35: Đã kết tối tới server socket thành công! <<::: }'));
  }

  Future<void> getUser() async {
    UserModel? userStorage = await localStorage.getUserInfo();
    setState(() {
      user = userStorage;
    });
  }

  Future<List<DocumentModel>> getDocuments() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document?limit=5'));
      if (response.statusCode == 200) {
        final List<dynamic> documentsJson = jsonDecode(response.body)["data"];
        final List<DocumentModel> result = documentsJson
            .map((doc) => DocumentModel.fromJson(doc as Map<String, dynamic>))
            .toList();
        if (mounted) {
          setState(() {
            documents = result;
          });
        }
        return result;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
      // Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await localStorage.init();
      initializeSocketService();
      getUser();
      getDocuments();
      setState(() {});
    });

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
          hideBottomBar();
        }
      }
      if (direction == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showBottomBar();
        }
      }
    });
  }

  void hideBottomBar() {
    setState(() {});
  }

  void showBottomBar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
            child: Lottie.asset('assets/lotties/robot.json', height: 65),
            onTap: () {
              navigatorHelper.changeView(context, RouteNames.chatbot);
            }),
        body: CustomScrollView(
          controller: controllerPagination,
          cacheExtent: 100,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
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
                                  child: user!.avatar != ''
                                      ? Image.network(user!.avatar,
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          'assets/images/image_avt_default.jpg',
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/images/banner.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  )
                ]),
              ),
            ),
            SliverToBoxAdapter(
                child: isFilterVisible
                    ? const FilterPage()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isFilterVisible = true; //Hiện Filterpage
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const FilterPage()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(
                                      0xFF0EBF7E)), // Set the button color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15), // Set the border radius
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/svgs/filter_3_line.svg',
                                  height: 20.0,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Lọc kết quả',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            // const SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 5),
            //     child: Text(
            //       'Tài liệu mới',
            //       textAlign: TextAlign.left,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: AppColor.darkblueColor,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        navigatorHelper.changeView(
                            context, RouteNames.description,
                            params: {'documentId': documents[index].id});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        child: NewDocument(documentModel: documents[index]),
                      ));
                },
                childCount: documents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
