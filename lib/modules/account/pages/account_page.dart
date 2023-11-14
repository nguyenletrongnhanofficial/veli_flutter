import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veli_flutter/modules/profile/pages/profile_page.dart';
import 'package:veli_flutter/modules/save/manage_page.dart';
import 'package:veli_flutter/modules/setting/pages/log_out.dart';
import 'package:veli_flutter/modules/setting/pages/setting_page.dart';
import 'package:veli_flutter/modules/setting/pages/update_password.dart';

class RowContent {
  String iconLeadingURL;
  String content;
  Function itemFunction;

  RowContent(
      {required this.iconLeadingURL,
      required this.content,
      required this.itemFunction});
}

final allRowContent = [
  RowContent(
      iconLeadingURL: 'assets/images/account.jpg',
      content: 'My profile ',
      itemFunction: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      }),
  RowContent(
      iconLeadingURL: 'assets/images/post_management.jpg',
      content: 'Quản lý bài đăng',
      itemFunction: (BuildContext context) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => ManagePage())));
      }),
  // RowContent(
  // iconLeadingURL: 'assets/images/salemanagement.jpg',
  // content: 'Quản lý hàng bán',
  // itemFunction: () {}),
  // RowContent(
  // iconLeadingURL: 'assets/images/salemanagement.jpg',
  // content: 'Quản lý hàng mua',
  // itemFunction: () {}),
  // RowContent(
  // iconLeadingURL: 'assets/images/revenuemanagement.jpg',
  // content: 'Quản lý doanh thu',
  // itemFunction: () {}),
  RowContent(
      iconLeadingURL: 'assets/images/evaluate.jpg',
      content: 'Phản hồi/ Đánh giá ứng dụng', // link vào gg drive

      itemFunction: (BuildContext context) {
        openFeedback();
      }),
  RowContent(
      iconLeadingURL: 'assets/images/setting.jpg',
      content: 'Đổi mật khẩu',
      itemFunction: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatePassword(),
          ),
        );
      }),
  RowContent(
      iconLeadingURL: 'assets/images/signout.png',
      content: 'Đăng xuất',
      itemFunction: (ctxRoot) {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            backgroundColor: Colors.transparent,
            barrierColor: const Color(0xFF2C373B).withOpacity(0.6),
            isScrollControlled: true,
            context: ctxRoot,
            builder: (ctx) => SizedBox(
                  height: !(MediaQuery.of(ctxRoot).orientation ==
                          Orientation.landscape)
                      ? (MediaQuery.of(ctxRoot).size.height -
                              MediaQuery.of(ctxRoot).padding.top) /
                          2
                      : (MediaQuery.of(ctxRoot).size.height -
                              MediaQuery.of(ctxRoot).padding.top) *
                          0.85,
                  child: const LogOut(),
                ));
      }),
];

openFeedback() async {
  String url =
      'https://docs.google.com/forms/d/e/1FAIpQLSdvL-s18Zox5oouqe-BizQRVyhecTty2OtDwRkrypCiTm0CdQ/viewform';
  final can = await canLaunch(url);
  print(can);
  if (can) {
    // ignore: deprecated_member_use5
    await launch(url);
  } else {
    throw 'ko the mo lien ket : $url';
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xFFFAFAFD),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text(
        'Tài khoản',
        style: TextStyle(
            color: Color(0xFF0D0D26),
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFD),
        appBar: appBar,
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(children: [
            for (int i = 0; i < allRowContent.length; i++) ...[
              Column(
                children: [
                  ListTile(
                    tileColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    leading: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image(
                            image: AssetImage(
                          allRowContent[i].iconLeadingURL,
                        ))),
                    title: Text(
                      allRowContent[i].content,
                      style: const TextStyle(
                          color: Color(0xFF150B3D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Container(
                      margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                      child: IconButton(
                        onPressed: () async {
                          if (allRowContent[i].itemFunction != null) {
                            await allRowContent[i].itemFunction(context);
                          }
                        },
                        icon: const Image(
                            width: 24,
                            height: 24,
                            image: AssetImage('assets/images/Select.png')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              )
            ]
          ]),
        )),
      ),
    );
  }
}
