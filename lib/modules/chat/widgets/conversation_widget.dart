// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ConversationWidget extends StatefulWidget {
  final String? username;
  final String? message;
  final int? unread;
  const ConversationWidget({
    required this.username,
    required this.message,
    required this.unread,
    super.key,
  });

  @override
  State<ConversationWidget> createState() => _ConversationWidget();
}

class _ConversationWidget extends State<ConversationWidget> {
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image.asset(
              'assets/images/image_avt_default.jpg',
              height: 65,
              width: 65,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: SizedBox(
                    width: width * 0.5, // Chiều dài cho phép
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // căn chỉnh name,, text thẳng cùng mép lề
                        children: [
                          Text(
                            '${widget.username}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${widget.message}',
                            style: TextStyle(
                              overflow: TextOverflow
                                  .ellipsis, // biến thành ... khi dài quá chiều dài cho phép (cần có widget set chiều dài, ví dụ sizedbox)
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Column(
                    children: [
                      Text(
                        '5m ago',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        Positioned(
                          top: 1,
                          left: 4.5,
                          child: Text(
                            '${widget.unread}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ])
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
