import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class NewDocument extends StatelessWidget {
  const NewDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 15, 15),
                  child: Image.asset(
                    'assets/images/image_avt_default.jpg',
                    width: 120,
                    height: 140,
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Tên tài liệu',
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColor.darkblueColor,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          'Giá tiền (VNĐ)',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.darkblueColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          'Tên trường đại học',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.darkblueColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          'Tài liệu này gồm 400 trang mình mới in hôm qua nên còn rất mới nha',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.darkblueColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: Image.asset(
                      'assets/images/image_avt_default.jpg',
                      width: 5,
                      height: 5,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Tên tôi là',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 0),
                  const Expanded(
                    child: Text(
                      'Địa điểm ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Thời gian',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.bookmark,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // Xử lý khi nhấp vào kí hiệu Bookmark
                    },
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
