import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/converation_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/chat/widgets/conversation_widget.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ConversationPage extends StatefulWidget {
  ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  LocalStorageService localStorage = LocalStorageService();
  late Future<List<ConversationModel>> _conversationsFuture;

  Future<List<ConversationModel>> getConversations() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/chat/conversations'));

      if (response.statusCode == 200) {
        final List<dynamic> conversationsJson =
            jsonDecode(response.body)["data"];

        final List<ConversationModel> result = conversationsJson
            .map((doc) =>
                ConversationModel.fromJson(doc as Map<String, dynamic>))
            .toList();

        return result;
      }

      return [];
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/conversation_page.dart - Line: 24: $e');
      return [];
    }
  }

  Future<void> _onRefresh() async {
    // Cập nhật _conversationsFuture với một Future mới mỗi khi kéo xuống để làm mới
    setState(() {
      _conversationsFuture = getConversations();
    });
  } 

  @override
  void initState() {
    super.initState();
    _conversationsFuture = getConversations();
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.backgroundColor,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.2,
                ),
                Container(
                  width: width * 0.31,
                  child: const Text('Tin nhắn',
                      style: TextStyle(color: Colors.black)),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      width: width * 0.33,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 40),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.book,
                                  color: Colors.green,
                                )),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 30),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: 'Tìm kiếm tin nhắn',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0)),
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: FutureBuilder(
                    future: _conversationsFuture,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        final List<ConversationModel> data = snapshot.data!;
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  navigatorHelper.changeView(
                                      context, RouteNames.message, params: {
                                    'conversation_id': data[index].id
                                  });
                                },
                                child: ConversationWidget(
                                  name: data[index].name,
                                  members: data[index].members,
                                  message: data[index].lastMessage,
                                  unread: data[index].unreadCount,
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    })),
              ),
              // ConversationWidget(
              // username: 'Kim Linh',
              // message:
              // 'Kim Linh dễ thương, cute, phô mai que, bánh tráng trộn, hột vịt lộn, trứng cút lắc',
              // unread: 3,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
