import 'package:flutter/material.dart';

import '../../auth/widgets/auth_action_button.dart';
import '../widgets/post_form_text_field.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút mũi tên quay lại
          },
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ĐĂNG TÀI LIỆU',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF150b3d),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/image_avt_default.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF150b3d),
                      ),
                    ),
                    Text(
                      'Địa chỉ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              PostFormTextField(
                label: 'Tiêu đề',
                hint: 'Viết tiêu đề của tài liệu cần bán',
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              PostFormTextField(
                label: 'Mô tả chi tiết',
                hint: 'Mô tả càng chi tiết sẽ càng giúp bạn bán dễ dàng hơn',
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              PostFormTextField(
                label: 'Giá',
                hint: 'Nhập giá mà bạn cần bán',
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const Text(
                    'Tặng miễn phí',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              PostFormTextField(
                label: 'Trường',
                hint: 'Nhập tên trường để mọi người dễ tìm thấy tài liệu hơn',
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              PostFormTextField(
                label: 'Địa chỉ',
                hint: 'Nhập địa chỉ bạn cần bán',
              ),
            ]),
            AuthActionButton(
              text: 'Đăng bài',
              onPressed: () {
                // Xử lý BE
              },
            ),
          ],
        ),
      ),
    );
  }
}
