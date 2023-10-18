import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veli_flutter/modules/chat/pages/chat_page.dart';
import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';

class Descriptionpage extends StatefulWidget {
  const Descriptionpage({Key? key}) : super(key: key);

  @override
  State<Descriptionpage> createState() => _DescriptionpageState();
}

class _DescriptionpageState extends State<Descriptionpage> {
  Future<void> _launchPhone(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber';
      Uri uri = Uri.parse(url);
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(''),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image_bg_appbar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 10000),
                    width: 10000,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/images/image_avt_default.jpg',
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Đặng Kim Liên',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Lập trình web',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Giá: 500 000đ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Trường ĐH Tài nguyên và Môi trường TP.HCM',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Đã đăng 1 ngày trước',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mô tả tài liệu',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ReadMoreText(
                    '',
                    trimLines: 3,
                    textScaleFactor: 1,
                    colorClickableText: Colors.grey,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Xem thêm',
                    trimExpandedText: 'Rút gọn',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    moreStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hình ảnh',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Image.asset(
                      'assets/images/image_book.jpg',
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Vị trí',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: CustomGoogleMap(),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _launchPhone("Số điện thoại của người bạn cần gọi");
                      },
                      child: Text(
                        'Gọi điện',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              user_id: "",
                              username: "",
                              state: null,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Nhắn tin',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
