import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';

class Descriptionpage extends StatefulWidget {
  const Descriptionpage({super.key});

  @override
  State<Descriptionpage> createState() => _DescriptionpageState();
}

class _DescriptionpageState extends State<Descriptionpage> {
  Future<void> _launchPhone(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber';
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              // margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/image_bg_appbar.jpg'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/image_avt_default.jpg',
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Đặng Kim Liên',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Lập trình web',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Giá: 500 000đ',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          //shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trường ĐH Tài nguyên và Môi trường TP.HCM',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Đã đăng 1 ngày trước',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Mô tả tài liệu',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          1, // index trong list (VD 5 thì lặp lại 5 lần nd)
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ReadMoreText(
                                            'Đây là tài liệu môn lập trình Web tôi học từ năm 3. Quyển này bao gồm 200 trang (tặng thêm tài liệu ôn thi trắc nghiệm). Kiến thức sẽ học là html, css, javascript. Tài liệu này cực kỳ hiếm và rất quý,hiện tôi đang khốn khổ cần tiền gấp, mong muốn pass lại cho ai cần. Đảm bảo 99,9% sau khi học xong quyển này bạn sẽ trở thành FE siêu cấp vũ trụ không ai địch lại, còn không thì bạn chính là 0,1% còn lại. Tôi đã được kiểm chứng trong giới IT. Chúc bạn thành công (có đấu giá khi số lượng mua nhiều). Nhanh tay thì còn, chậm tay chắc vẫn còn. ',
                                            trimLines:
                                                3, // từ 3 lines -> trim & show: Xem thêm
                                            textScaleFactor: 1,
                                            colorClickableText:
                                                Colors.grey, // rút gọn
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Xem thêm',
                                            trimExpandedText: 'Rút gọn',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ), // định dạng VB ban đầu

                                            moreStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .grey), // style button Xem thêm
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Hình ảnh',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      'assets/images/image_book.jpg',
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Vị trí',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: CustomGoogleMap()),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          _launchPhone("0337825497");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[400]),
                                        child: Text(
                                          'Gọi cho người bán',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF0EBF7E)),
                                        child: Text(
                                          'NHẮN TIN VỚI NGƯỜI BÁN',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
