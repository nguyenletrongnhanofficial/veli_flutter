import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ChatPage extends StatefulWidget {
  final String? username;
  final bool? state;
  const ChatPage({
    required this.username,
    required this.state,
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, //vị trí icon
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/image_avt_default.jpg',
                              height: 60,
                              width: 60,
                            )),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.username}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green[400],
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                widget.state == true
                                    ? Text('Online',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ))
                                    : Text(
                                        'Offline',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone,
                          color: Colors.green[400],
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.green[400],
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
