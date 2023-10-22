import 'package:flutter/material.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Thực hiện hành động khi nút quay lại được nhấp
            // Ví dụ: quay lại màn hình trước đó
          },
        ),
        actions: [
          SizedBox(width: 16.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Thêm mới',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_box_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        navigatorHelper.changeView(context, RouteNames.addpost);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(8.0)), // Độ cong ở 4 góc
              ),
              padding:
                  EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 20),
              child: Text(
                'Quản lý bài đăng',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
