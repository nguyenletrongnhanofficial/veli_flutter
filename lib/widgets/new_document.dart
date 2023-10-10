import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/utils/app_color.dart';

class NewDocument extends StatelessWidget {
  final String url;
  // final UserModel? seller;
  final String sellerName;
  final String address;
  final String createdAt;
  
  NewDocument({key, 
    required this.url,
    required this.sellerName,
    required this.address,
    required this.createdAt,
    });

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
                  child: Image.network(url,
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
                  Expanded(
                    child: Text(
                      '$sellerName',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: Text(
                      '$address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(createdAt))}',
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
