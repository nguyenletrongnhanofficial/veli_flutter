// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veli_flutter/models/message_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ConversationWidget extends StatefulWidget {
  final String name;
  final MessageModel? message;
  final List<UserModel> members;
  final int unread;
  const ConversationWidget({
    required this.name,
    required this.message,
    required this.members,
    required this.unread,
    super.key,
  });

  @override
  State<ConversationWidget> createState() => _ConversationWidget();
}

class _ConversationWidget extends State<ConversationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
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
              child: widget.members[0].avatar == ''
                  ? Image.asset('assets/images/image_avt_default.jpg',
                      height: 55, width: 55, fit: BoxFit.cover)
                  : Image.network(widget.members[0].avatar,
                      height: 55, width: 55, fit: BoxFit.cover)),
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
                            widget.name,
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
                            widget.message != null ? widget.message!.content : "Hãy gửi lời chào...",
                            style: TextStyle(
                              overflow: TextOverflow
                                  .ellipsis, // biến thành ... khi dài quá chiều dài cho phép (cần có widget set chiều dài, ví dụ sizedbox)
                              fontSize: 12,
                              fontWeight: widget.unread != 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
                        widget.message != null ?
                        DateFormat('dd/MM/yyyy HH:mm').format(
                            DateTime.parse(widget.message!.createdAt!)
                                .toLocal()) : "",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (widget.unread != 0)
                        Stack(alignment: Alignment.center, children: [
                          Center(
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${widget.unread}',
                              style: TextStyle(
                                fontSize: 10,
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
