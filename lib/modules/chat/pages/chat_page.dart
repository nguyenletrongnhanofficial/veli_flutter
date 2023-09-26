import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/chat/widgets/message_widget.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ChatPage extends StatefulWidget {
  final String? user_id;
  final String? username;
  final bool? state;
  const ChatPage({
    required this.user_id,
    required this.username,
    required this.state,
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<dynamic, dynamic>> messages = [
    {
      'user_id': '1',
      'username': 'Be Lien',
      'message': 'Hello',
      'time': DateTime(2023, 09, 23, 11, 25),
    },
    {
      'user_id': '2',
      'username': 'Be Lien 2',
      'message': 'hi',
      'time': DateTime(2023, 09, 23, 11, 26),
    },
    {
      'user_id': '2',
      'username': 'Be Lien 2',
      'message': 'I love du',
      'time': DateTime(2023, 09, 23, 11, 27),
    },
    {
      'user_id': '1',
      'username': 'Be Lien',
      'message': 'Cảm ơn bro',
      'time': DateTime(2023, 09, 23, 11, 27),
    },
  ];

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
        body: Body());
  }

  Container Body() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SingleChildScrollView(),
    );
  }

  Column SingleChildScrollView() {
    return Column(
      children: [
        Header(),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.7,
          // width: MediaQuery.of(context).size.width,

          child: ListView.builder(
            controller: _scrollController,
            reverse: true, // đảo ngược thứ tự của danh sách
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final reversedIndex =
                  messages.length - 1 - index; // đảo ngược thứ tự index
              return MessageWidget(
                  message: messages[reversedIndex]['message'],
                  position: widget.user_id == messages[reversedIndex]['user_id']
                      ? 'right'
                      : 'left',
                  time: messages[reversedIndex]['time']);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(hintText: 'Nhập tin nhắn...'),
              ),
            ),
            IconButton(
              // Hàm xử lý khi nhấn nút gửi
              onPressed: () {
                String messageInput = messageController.text.toString();
                if (messageInput.isNotEmpty) {
                  final newMessage = {
                    'user_id': '1',
                    'username': 'Be Lien',
                    'message': messageInput,
                    'time': DateTime.now(),
                  };

                  setState(() {
                    messages.add(newMessage); // thêm vào cuối list
                    //messages.insert(0, newMessage); // thêm vào đầu list
                    messageController.text = ''; // xóa nội dung ô nhập VB
                  });
                }
              },
              icon: Icon(Icons.send),
            ),
          ],
        )
      ],
    );
  }

  Container Header() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền của Container
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Màu của shadow
            offset: Offset(
                0, 1), // Điều chỉnh vị trí shadow (0, 4) tương ứng với bottom
            blurRadius: 3, // Độ mờ của shadow
            spreadRadius: 0, // Độ phân tán của shadow
          ),
        ],
      ),
      child: Row(
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
                        height: 50,
                        width: 50,
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
          ),
        ],
      ),
    );
  }
}
