import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/models/converation_model.dart';
import 'package:veli_flutter/models/message_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/chat/widgets/message_widget.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/services/socket_service.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ChatPage extends StatefulWidget {
  final Map<String, String>? params;
  ChatPage({
    Key? key,
    this.params,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  LocalStorageService localStorage = LocalStorageService();
  late SocketService socket = SocketService.getInstance(authorizationToken: '');

  bool isGetMessage = false;
  UserModel? user;
  ConversationModel? conversation;
  List<MessageModel> messages = [];

  void joinRoom() {
    print(
        'File: lib/modules/chat/pages/chat_page.dart - Line: 38: ${widget.params.toString()} ');
    socket.emitEvent(
        'join-room', {'conversation_id': widget.params!['conversation_id']});
    socket.onEvent('chat-message', (data) {
      MessageModel newMsg = MessageModel.fromJson(data);
      if (mounted) {
        setState(() {
          messages.add(newMsg);
        });
      }
    });
  }

  void readMessages() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.put(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse(
              '$apiHost/api/chat/conversations/${widget.params!["conversation_id"]}'));

      if (response.statusCode == 200) {}
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/conversation_page.dart - Line: 24: $e');
    }
  }

  Future<List<MessageModel>> getMessages() async {
    if (isGetMessage) return [];
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/chat/${widget.params!["conversation_id"]}'));

      if (response.statusCode == 200) {
        final List<dynamic> messagesJson = jsonDecode(response.body)["data"];
        print('File: lib/modules/chat/pages/chat_page.dart - Line: 78: $messagesJson ');

        final List<MessageModel> result = messagesJson
            .map((doc) => MessageModel.fromJson(doc as Map<String, dynamic>))
            .toList();

        setState(() {
          messages = result;
          isGetMessage = true;
        });
        return result;
      }
      return [];
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/conversation_page.dart - Line: 24: $e');
      return [];
    }
  }

  Future<void> getConversations() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse(
              '$apiHost/api/chat/conversations/${widget.params!["conversation_id"]}'));

      if (response.statusCode == 200) {
        final dynamic conversationsJson = jsonDecode(response.body)["data"];
        print('File: lib/modules/chat/pages/chat_page.dart - Line: 109: $conversationsJson ');

        final ConversationModel result =
            ConversationModel.fromJson(conversationsJson);

        setState(() {
          conversation = result;
        });
      }
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/conversation_page.dart - Line: 24: $e');
    }
  }

  Future<void> getUser() async {
    UserModel? userStorage = await localStorage.getUserInfo();
    setState(() {
      user = userStorage;
    });
  }

  @override
  void initState() {
    readMessages();
    getUser();
    getMessages();
    getConversations();
    joinRoom();
    super.initState();
  }

  @override
  void dispose() {
    socket.emitEvent(
        'leave-room', {'conversation_id': widget.params!['conversation_id']});
    socket.offEvent('chat-message');
    super.dispose();
  }

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
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        body: !isGetMessage
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : buildBody());
  }

  Container buildBody() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: buildChatMessages(),
    );
  }

  Column buildChatMessages() {
    return Column(
      children: [
        buildHeader(),
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
            return  messages[reversedIndex].createdBy != null ?
            MessageWidget(
                user: messages[reversedIndex].createdBy,
                message: messages[reversedIndex].content,
                position: user?.id == messages[reversedIndex].createdBy!.id
                    ? 'right'
                    : 'left',
                time: messages[reversedIndex].createdAt!) :
                Container();
          },
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(hintText: 'Nhập tin nhắn...'),
              ),
            ),
            IconButton(
              // Hàm xử lý khi nhấn nút gửi
              onPressed: () {
                String messageInput = messageController.text.toString();
                if (messageInput.isNotEmpty) {
                  final newMessage = {
                    'id': DateTime.fromMillisecondsSinceEpoch(1000).toString(),
                    'created_by': user!.toJson(),
                    'content': messageInput,
                    'createdAt': DateTime.now().toString(),
                  };
                  socket.emitEvent('chat-message', {
                    'conversation_id': widget.params!['conversation_id'],
                    'type': 1,
                    'content': messageInput,
                  });

                  List<MessageModel> updatedMessages = List.from(messages);
                  updatedMessages.add(MessageModel.fromJson(newMessage));

                  setState(() {
                    messages = updatedMessages;
                    messageController.text = '';
                  });
                }
              },
              icon: const Icon(Icons.send),
            )
          ],
        )
      ],
    );
  }

  Container buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
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
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 60,
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: (conversation == null || (conversation != null && conversation!.members[0].avatar == ''))
                            ? Image.asset('assets/images/image_avt_default.jpg',
                                height: 55, width: 55, fit: BoxFit.cover)
                            : Image.network(conversation!.members[0].avatar,
                                height: 55, width: 55, fit: BoxFit.cover)),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation != null ? conversation!.name : "",
                        style: const TextStyle(
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
                          const SizedBox(
                            width: 5,
                          ),
                          true == true
                              ? const Text('Online',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                              : const Text(
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.phone,
          //           color: Colors.green[400],
          //         )),
          //     IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.search,
          //           color: Colors.green[400],
          //         ))
          //   ],
          // ),
        ],
      ),
    );
  }
}
