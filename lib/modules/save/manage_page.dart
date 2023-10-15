import 'package:flutter/material.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Thực hiện hành động khi nút quay lại được nhấp
            // Ví dụ: quay lại màn hình trước đó
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Row(
          children: [
            Text(
              'QL bài đăng',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 16.0),
            Text(
              'Thêm mới',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                navigatorHelper.changeView(context, RouteNames.addpost);
              },
            ),
            Text(
              'Lưu',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                navigatorHelper.changeView(context, RouteNames.save);
              },
            ),
          ],
        ),
      ),
    );
  }
}
