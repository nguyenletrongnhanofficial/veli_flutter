import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/widgets/auth_action_button.dart';

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
              'Quản lý bài đăng',
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
                // Thực hiện hành động khi biểu tượng được nhấp
                // Ví dụ: mở trang thêm mới
              },
            ),
          ],
        ),
      ),
    );
  }
}
