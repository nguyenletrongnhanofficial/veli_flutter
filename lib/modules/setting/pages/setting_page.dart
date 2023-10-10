import 'package:flutter/material.dart';
import 'package:veli_flutter/widgets/cutsom_switch.dart';
import './update_password.dart';
import './log_out.dart';

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
      iconLeadingURL: 'assets/images/notification.png',
      content: 'Thông báo',
      itemFunction: () {}),
  RowContent(
      iconLeadingURL: 'assets/images/Subtract.png',
      content: 'Giao diện tối',
      itemFunction: () {}),
  RowContent(
      iconLeadingURL: 'assets/images/changepassword.png',
      content: 'Đổi mật khẩu',
      itemFunction: (ctxRoot) {
        Navigator.of(ctxRoot).push(
            MaterialPageRoute(builder: (context) => const UpdatePassword()));
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
      })
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  bool isNotification = true;

  bool isDarkMode = true;

  void changeNotification() {
    setState(() {
      isNotification = !isNotification;
    });
  }

  void changeDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Widget itemSwitch(RowContent item, Widget flutterSwitch) {
    return ListTile(
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      leading: Image(image: AssetImage(item.iconLeadingURL)),
      title: Text(
        item.content,
        style: const TextStyle(
            color: Color(0xFF150B3D),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
      trailing: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          height: 30,
          width: 30,
          child: FittedBox(child: flutterSwitch)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xFFFAFAFD),
      leading: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Image(image: AssetImage('assets/images/arrow.png')),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Cài đặt',
        style: TextStyle(
            color: Color(0xFF0D0D26),
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFD),
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(children: [
          // row 1
          itemSwitch(
            allRowContent[0],
            CustomSwitch(
                activeColor: const Color(0xFF56CD54),
                inactiveColor: const Color(0xFFE5E5E5),
                activeToggleColor: Colors.white,
                inactiveToggleColor: const Color(0xFF3D4859),
                value: isNotification,
                onToggle: ((value) => {changeNotification()})),
          ),
          const SizedBox(
            height: 8,
          ),
          // row 2
          itemSwitch(
            allRowContent[1],
            CustomSwitch(
                activeColor: const Color(0xFF56CD54),
                inactiveColor: const Color(0xFFE5E5E5),
                activeToggleColor: Colors.white,
                inactiveToggleColor: const Color(0xFF3D4859),
                value: isDarkMode,
                onToggle: ((value) => {changeDarkMode()})),
          ),
          const SizedBox(
            height: 8,
          ),
          for (int i = 2; i < allRowContent.length; i++) ...[
            Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading:
                      Image(image: AssetImage(allRowContent[i].iconLeadingURL)),
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
                      onPressed: () {
                        allRowContent[i].itemFunction(context);
                      },
                      icon: const Image(
                          width: 8,
                          height: 16,
                          image: AssetImage('assets/images/Select.png')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )
          ]
        ]),
      )),
    );
  }
}
