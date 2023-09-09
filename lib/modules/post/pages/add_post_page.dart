import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

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
              padding: EdgeInsets.fromLTRB(15, 20, 30, 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ĐĂNG TÀI LIỆU',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkblueColor,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkblueColor,
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
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PostFormTextField(
                label: 'Tiêu đề',
                hint: 'Viết tiêu đề của tài liệu cần bán',
              ),
            ]),
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PostFormTextField(
                label: 'Mô tả chi tiết',
                hint: 'Mô tả càng chi tiết sẽ càng giúp bạn bán dễ dàng hơn',
              ),
            ]),
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PostFormTextField(
                label: 'Trường',
                hint: 'Nhập tên trường để mọi người dễ tìm thấy tài liệu hơn',
              ),
            ]),
            const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PostFormTextField(
                label: 'Địa chỉ',
                hint: 'Nhập địa chỉ bạn cần bán',
              ),
            ]),
            const SizedBox(
              height: 40,
            ),
            AuthActionButton(
              text: 'ĐĂNG BÀI',
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
